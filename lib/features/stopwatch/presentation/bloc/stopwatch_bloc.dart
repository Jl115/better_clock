import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/time_ticker_service.dart';
import '../../domain/entities/stopwatch_lap.dart';
import '../../domain/entities/stopwatch_session.dart';
import '../../domain/usecases/stopwatch_usecases.dart';
import '../../../customization/domain/usecases/customization_usecases.dart';
import 'stopwatch_event.dart';
import 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final GetOrCreateCurrentSessionUseCase _getOrCreateSession;
  final UpdateSessionUseCase _updateSession;
  final AddLapUseCase _addLap;
  final DeleteLapsUseCase _deleteLaps;
  final GetStopwatchCustomizationUseCase _getCustomization;
  final SaveStopwatchCustomizationUseCase _saveCustomization;
  final TimeTickerService _timeTicker;

  StreamSubscription<DateTime>? _tickSubscription;

  StopwatchBloc({
    required GetOrCreateCurrentSessionUseCase getOrCreateSession,
    required UpdateSessionUseCase updateSession,
    required AddLapUseCase addLap,
    required DeleteLapsUseCase deleteLaps,
    required GetStopwatchCustomizationUseCase getCustomization,
    required SaveStopwatchCustomizationUseCase saveCustomization,
    required TimeTickerService timeTicker,
  })  : _getOrCreateSession = getOrCreateSession,
        _updateSession = updateSession,
        _addLap = addLap,
        _deleteLaps = deleteLaps,
        _getCustomization = getCustomization,
        _saveCustomization = saveCustomization,
        _timeTicker = timeTicker,
        super(StopwatchState()) {
    on<LoadStopwatch>(_onLoad);
    on<StartStopwatch>(_onStart);
    on<StopStopwatch>(_onStop);
    on<ResetStopwatch>(_onReset);
    on<LapStopwatch>(_onLap);
    on<TickStopwatch>(_onTick);
    on<LoadCustomization>(_onLoadCustomization);
    on<UpdateCustomization>(_onUpdateCustomization);

    add(const LoadStopwatch());
    add(const LoadCustomization());
  }

  Duration _computeCurrentTotal(StopwatchSession session) {
    if (session.isRunning && session.lastStartTime != null) {
      final now = DateTime.now();
      final elapsed = now.difference(session.lastStartTime!);
      return session.elapsedBeforePause + elapsed;
    }
    return session.elapsedBeforePause;
  }

  Future<void> _onLoad(LoadStopwatch event, Emitter<StopwatchState> emit) async {
    final result = await _getOrCreateSession();
    result.when(
      success: (session) {
        final duration = _computeCurrentTotal(session);
        emit(state.copyWith(
          session: session,
          isRunning: session.isRunning,
          currentTotalDuration: duration,
          isLoading: false,
        ));
        if (session.isRunning) {
          _subscribeTicks();
        }
      },
      failure: (err) => emit(state.copyWith(
        errorMessage: err.toString(),
        isLoading: false,
      )),
    );
  }

  void _onStart(StartStopwatch event, Emitter<StopwatchState> emit) async {
    final session = state.session;
    if (session == null) return;

    final newSession = session.copyWith(
      isRunning: true,
      lastStartTime: DateTime.now(),
    );
    await _updateSession(newSession);
    _subscribeTicks();
    emit(state.copyWith(
      session: newSession,
      isRunning: true,
    ));
  }

  void _onStop(StopStopwatch event, Emitter<StopwatchState> emit) async {
    final session = state.session;
    if (session == null || !session.isRunning) return;

    final now = DateTime.now();
    final elapsed = session.lastStartTime != null
        ? now.difference(session.lastStartTime!)
        : Duration.zero;
    final newSession = session.copyWith(
      isRunning: false,
      elapsedBeforePause: session.elapsedBeforePause + elapsed,
      totalDuration: session.elapsedBeforePause + elapsed,
      lastStartTime: null,
    );
    await _updateSession(newSession);
    _unsubscribeTicks();
    emit(state.copyWith(
      session: newSession,
      isRunning: false,
      currentTotalDuration: newSession.totalDuration,
    ));
  }

  void _onReset(ResetStopwatch event, Emitter<StopwatchState> emit) async {
    final session = state.session;
    if (session == null) return;

    final newSession = session.copyWith(
      isRunning: false,
      totalDuration: Duration.zero,
      elapsedBeforePause: Duration.zero,
      lastStartTime: null,
      laps: const [],
    );
    await _updateSession(newSession);
    if (session.laps.isNotEmpty) {
      await _deleteLaps(session.id!);
    }
    _unsubscribeTicks();
    emit(state.copyWith(
      session: newSession,
      isRunning: false,
      currentTotalDuration: Duration.zero,
    ));
  }

  void _onLap(LapStopwatch event, Emitter<StopwatchState> emit) async {
    final session = state.session;
    if (session == null || session.id == null) return;

    final now = DateTime.now();
    final currentTotal = _computeCurrentTotal(session);
    final lapNumber = session.laps.length + 1;
    final previousTotal = session.laps.isNotEmpty
        ? session.laps.last.totalDuration
        : Duration.zero;
    final lapDuration = currentTotal - previousTotal;

    final lap = StopwatchLap(
      sessionId: session.id!,
      lapNumber: lapNumber,
      lapDuration: lapDuration,
      totalDuration: currentTotal,
      createdAt: now,
    );
    await _addLap(lap);

    final updatedLaps = List<StopwatchLap>.from(session.laps)..add(lap);
    final newSession = session.copyWith(laps: updatedLaps);
    await _updateSession(newSession);
    emit(state.copyWith(session: newSession));
  }

  void _onTick(TickStopwatch event, Emitter<StopwatchState> emit) async {
    final session = state.session;
    if (session == null || !session.isRunning) return;
    final duration = _computeCurrentTotal(session);
    emit(state.copyWith(currentTotalDuration: duration));
  }

  Future<void> _onLoadCustomization(
    LoadCustomization event,
    Emitter<StopwatchState> emit,
  ) async {
    final result = await _getCustomization();
    result.when(
      success: (customization) => emit(state.copyWith(customization: customization)),
      failure: (_) {},
    );
  }

  Future<void> _onUpdateCustomization(
    UpdateCustomization event,
    Emitter<StopwatchState> emit,
  ) async {
    await _saveCustomization(event.customization);
    emit(state.copyWith(customization: event.customization));
  }

  void _subscribeTicks() {
    _unsubscribeTicks();
    _timeTicker.start(interval: const Duration(milliseconds: 10));
    _tickSubscription = _timeTicker.tickStream.listen((now) {
      add(TickStopwatch(now));
    });
  }

  void _unsubscribeTicks() {
    _tickSubscription?.cancel();
    _tickSubscription = null;
    _timeTicker.stop();
  }

  @override
  Future<void> close() {
    _unsubscribeTicks();
    return super.close();
  }
}

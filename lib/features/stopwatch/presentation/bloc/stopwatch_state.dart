import 'package:equatable/equatable.dart';

import '../../domain/entities/stopwatch_customization.dart';
import '../../domain/entities/stopwatch_session.dart';

class StopwatchState extends Equatable {
  final bool isRunning;
  final StopwatchSession? session;
  final Duration currentTotalDuration;
  final StopwatchCustomization customization;
  final bool isLoading;
  final String? errorMessage;

  const StopwatchState({
    this.isRunning = false,
    this.session,
    this.currentTotalDuration = Duration.zero,
    this.customization = const StopwatchCustomization(),
    this.isLoading = true,
    this.errorMessage,
  });

  StopwatchState copyWith({
    bool? isRunning,
    StopwatchSession? session,
    Duration? currentTotalDuration,
    StopwatchCustomization? customization,
    bool? isLoading,
    String? errorMessage,
  }) {
    return StopwatchState(
      isRunning: isRunning ?? this.isRunning,
      session: session ?? this.session,
      currentTotalDuration: currentTotalDuration ?? this.currentTotalDuration,
      customization: customization ?? this.customization,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isRunning,
        session,
        currentTotalDuration,
        customization,
        isLoading,
        errorMessage,
      ];
}

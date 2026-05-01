import '../../../../core/utils/result.dart';
import '../models/stopwatch_entity.dart';

import '../../domain/entities/stopwatch_lap.dart';
import '../../domain/entities/stopwatch_session.dart';
import '../../domain/repositories/stopwatch_repository.dart';
import '../datasources/stopwatch_local_datasource.dart';

class StopwatchRepositoryImpl implements IStopwatchRepository {
  final StopwatchLocalDataSource _dataSource;
  const StopwatchRepositoryImpl(this._dataSource);

  StopwatchSession _mapEntityToDomain(
    StopwatchSessionEntity e,
    List<StopwatchLap> laps,
  ) {
    return StopwatchSession(
      id: e.id,
      createdAt: DateTime.parse(e.createdAtIso),
      totalDuration: Duration(milliseconds: e.totalDurationMs),
      isRunning: e.isRunning,
      elapsedBeforePause: Duration(milliseconds: e.elapsedBeforePauseMs),
      lastStartTime: e.lastStartTimeIso != null
          ? DateTime.parse(e.lastStartTimeIso!)
          : null,
      laps: laps,
    );
  }

  StopwatchSessionEntity _mapDomainToEntity(StopwatchSession s) {
    return StopwatchSessionEntity(
      id: s.id,
      createdAtIso: s.createdAt.toIso8601String(),
      totalDurationMs: s.totalDuration.inMilliseconds,
      isRunning: s.isRunning,
      elapsedBeforePauseMs: s.elapsedBeforePause.inMilliseconds,
      lastStartTimeIso: s.lastStartTime?.toIso8601String(),
    );
  }

  LapEntity _mapLapToEntity(StopwatchLap l) {
    return LapEntity(
      id: l.id,
      sessionId: l.sessionId,
      lapNumber: l.lapNumber,
      lapDurationMs: l.lapDuration.inMilliseconds,
      totalDurationMs: l.totalDuration.inMilliseconds,
      createdAtIso: l.createdAt.toIso8601String(),
    );
  }

  StopwatchLap _mapLapEntityToDomain(LapEntity e) {
    return StopwatchLap(
      id: e.id,
      sessionId: e.sessionId,
      lapNumber: e.lapNumber,
      lapDuration: Duration(milliseconds: e.lapDurationMs),
      totalDuration: Duration(milliseconds: e.totalDurationMs),
      createdAt: DateTime.parse(e.createdAtIso),
    );
  }

  @override
  Future<Result<StopwatchSession, AppError>> createSession() async {
    try {
      final entity = StopwatchSessionEntity(
        createdAtIso: DateTime.now().toIso8601String(),
        totalDurationMs: 0,
        isRunning: false,
        elapsedBeforePauseMs: 0,
      );
      final id = await _dataSource.insertSession(entity);
      final session = StopwatchSession(
        id: id,
        createdAt: DateTime.now(),
        totalDuration: Duration.zero,
        isRunning: false,
        elapsedBeforePause: Duration.zero,
        laps: const [],
      );
      return Success(session);
    } catch (e) {
      return Failure(DatabaseError('Failed to create session: $e'));
    }
  }

  @override
  Future<Result<void, AppError>> updateSession(StopwatchSession session) async {
    try {
      final entity = _mapDomainToEntity(session);
      await _dataSource.updateSession(entity);
      return const Success(null);
    } catch (e) {
      return Failure(DatabaseError('Failed to update session: $e'));
    }
  }

  @override
  Future<Result<void, AppError>> deleteSession(int id) async {
    try {
      await _dataSource.deleteSession(id);
      return const Success(null);
    } catch (e) {
      return Failure(DatabaseError('Failed to delete session: $e'));
    }
  }

  @override
  Future<Result<List<StopwatchSession>, AppError>> getAllSessions() async {
    try {
      final entities = await _dataSource.getAllSessions();
      final sessions = <StopwatchSession>[];
      for (final e in entities) {
        final laps = await _loadLaps(e.id!);
        sessions.add(_mapEntityToDomain(e, laps));
      }
      return Success(sessions);
    } catch (e) {
      return Failure(DatabaseError('Failed to load sessions: $e'));
    }
  }

  @override
  Future<Result<StopwatchSession?, AppError>> getSessionById(int id) async {
    try {
      final entity = await _dataSource.getSessionById(id);
      if (entity == null) return const Success(null);
      final laps = await _loadLaps(id);
      return Success(_mapEntityToDomain(entity, laps));
    } catch (e) {
      return Failure(DatabaseError('Failed to load session: $e'));
    }
  }

  @override
  Future<Result<void, AppError>> addLap(StopwatchLap lap) async {
    try {
      final entity = _mapLapToEntity(lap);
      await _dataSource.insertLap(entity);
      return const Success(null);
    } catch (e) {
      return Failure(DatabaseError('Failed to add lap: $e'));
    }
  }

  @override
  Future<Result<List<StopwatchLap>, AppError>> getLapsBySessionId(
    int sessionId,
  ) async {
    try {
      final laps = await _loadLaps(sessionId);
      return Success(laps);
    } catch (e) {
      return Failure(DatabaseError('Failed to load laps: $e'));
    }
  }

  @override
  Future<Result<void, AppError>> deleteLapsBySessionId(int sessionId) async {
    try {
      await _dataSource.deleteLapsBySessionId(sessionId);
      return const Success(null);
    } catch (e) {
      return Failure(DatabaseError('Failed to delete laps: $e'));
    }
  }

  Future<List<StopwatchLap>> _loadLaps(int sessionId) async {
    final entities = await _dataSource.getLapsBySessionId(sessionId);
    return entities.map(_mapLapEntityToDomain).toList();
  }
}

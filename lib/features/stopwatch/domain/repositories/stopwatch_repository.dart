import '../../../../core/utils/result.dart';
import '../entities/stopwatch_lap.dart';
import '../entities/stopwatch_session.dart';

/// Repository interface for stopwatch sessions and laps.
/// Concrete implementations reside in the data layer.
abstract class IStopwatchRepository {
  Future<Result<StopwatchSession, AppError>> createSession();
  Future<Result<void, AppError>> updateSession(StopwatchSession session);
  Future<Result<void, AppError>> deleteSession(int id);
  Future<Result<List<StopwatchSession>, AppError>> getAllSessions();
  Future<Result<StopwatchSession?, AppError>> getSessionById(int id);

  Future<Result<void, AppError>> addLap(StopwatchLap lap);
  Future<Result<List<StopwatchLap>, AppError>> getLapsBySessionId(int sessionId);
  Future<Result<void, AppError>> deleteLapsBySessionId(int sessionId);
}

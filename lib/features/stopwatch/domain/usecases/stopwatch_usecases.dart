import '../../../../core/utils/result.dart';
import '../entities/stopwatch_lap.dart';
import '../entities/stopwatch_session.dart';
import '../repositories/stopwatch_repository.dart';

/// Create a new empty stopwatch session.
class CreateSessionUseCase {
  final IStopwatchRepository _repository;
  const CreateSessionUseCase(this._repository);

  Future<Result<int, AppError>> call() async {
    final result = await _repository.createSession();
    return result.when(
      success: (session) => Success(session.id!),
      failure: (err) => Failure(err),
    );
  }
}

/// Update an existing session (e.g., when paused/resumed).
class UpdateSessionUseCase {
  final IStopwatchRepository _repository;
  const UpdateSessionUseCase(this._repository);

  Future<Result<void, AppError>> call(StopwatchSession session) =>
      _repository.updateSession(session);
}

/// Delete a session and its laps by ID.
class DeleteSessionUseCase {
  final IStopwatchRepository _repository;
  const DeleteSessionUseCase(this._repository);

  Future<Result<void, AppError>> call(int id) =>
      _repository.deleteSession(id);
}

/// Fetch the current session (latest) or create one if none exists.
class GetOrCreateCurrentSessionUseCase {
  final IStopwatchRepository _repository;
  const GetOrCreateCurrentSessionUseCase(this._repository);

  Future<Result<StopwatchSession, AppError>> call() async {
    final allResult = await _repository.getAllSessions();
    return allResult.when(
      success: (sessions) async {
        if (sessions.isNotEmpty) {
          return Success(sessions.first);
        }
        final createResult = await _repository.createSession();
        return createResult.when(
          success: (s) => Success(s),
          failure: (err) => Failure(err),
        );
      },
      failure: (err) => Failure(err),
    );
  }
}

/// Record a new lap for the given session.
class AddLapUseCase {
  final IStopwatchRepository _repository;
  const AddLapUseCase(this._repository);

  Future<Result<void, AppError>> call(StopwatchLap lap) =>
      _repository.addLap(lap);
}

/// Delete all laps for a session (e.g., on reset).
class DeleteLapsUseCase {
  final IStopwatchRepository _repository;
  const DeleteLapsUseCase(this._repository);

  Future<Result<void, AppError>> call(int sessionId) =>
      _repository.deleteLapsBySessionId(sessionId);
}

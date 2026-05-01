import '../../../../core/data/local/app_database.dart';
import '../models/stopwatch_entity.dart';

/// Local datasource for stopwatch data, wrapping the Floor DAO.
class StopwatchLocalDataSource {
  final AppDatabase _database;
  const StopwatchLocalDataSource(this._database);

  Future<List<StopwatchSessionEntity>> getAllSessions() =>
      _database.stopwatchDao.findAllSessions();

  Future<StopwatchSessionEntity?> getSessionById(int id) =>
      _database.stopwatchDao.findSessionById(id);

  Future<int> insertSession(StopwatchSessionEntity session) =>
      _database.stopwatchDao.insertSession(session);

  Future<void> updateSession(StopwatchSessionEntity session) async {
    await _database.stopwatchDao.updateSession(session);
  }

  Future<void> deleteSession(int id) async {
    final entity = await _database.stopwatchDao.findSessionById(id);
    if (entity != null) {
      await _database.stopwatchDao.deleteSession(entity);
    }
  }

  Future<List<LapEntity>> getLapsBySessionId(int sessionId) =>
      _database.stopwatchDao.findLapsBySessionId(sessionId);

  Future<void> insertLap(LapEntity lap) =>
      _database.stopwatchDao.insertLap(lap);

  Future<void> deleteLapsBySessionId(int sessionId) =>
      _database.stopwatchDao.deleteLapsBySessionId(sessionId);
}

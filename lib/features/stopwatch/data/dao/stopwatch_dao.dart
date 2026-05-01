import 'package:floor/floor.dart';

import '../models/stopwatch_entity.dart';

@dao
abstract class StopwatchDao {
  @Query('SELECT * FROM stopwatch_sessions ORDER BY createdAtIso DESC')
  Future<List<StopwatchSessionEntity>> findAllSessions();

  @Query('SELECT * FROM stopwatch_sessions WHERE id = :id')
  Future<StopwatchSessionEntity?> findSessionById(int id);

  @Query('SELECT * FROM laps WHERE sessionId = :sessionId ORDER BY lapNumber ASC')
  Future<List<LapEntity>> findLapsBySessionId(int sessionId);

  @insert
  Future<int> insertSession(StopwatchSessionEntity session);

  @update
  Future<int> updateSession(StopwatchSessionEntity session);

  @delete
  Future<int> deleteSession(StopwatchSessionEntity session);

  @insert
  Future<void> insertLap(LapEntity lap);

  @Query('DELETE FROM laps WHERE sessionId = :sessionId')
  Future<void> deleteLapsBySessionId(int sessionId);
}

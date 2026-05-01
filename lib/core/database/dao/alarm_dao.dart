import 'package:floor/floor.dart';

import '../entities/alarm_entity.dart';

@dao
abstract class AlarmDao {
  @Query('SELECT * FROM alarms')
  Future<List<AlarmEntity>> findAllAlarms();

  @Query('SELECT * FROM alarms WHERE isEnabled = 1')
  Future<List<AlarmEntity>> findEnabledAlarms();

  @Query('SELECT * FROM alarms WHERE id = :id')
  Future<AlarmEntity?> findAlarmById(int id);

  @insert
  Future<int> insertAlarm(AlarmEntity alarm);

  @update
  Future<int> updateAlarm(AlarmEntity alarm);

  @delete
  Future<int> deleteAlarm(AlarmEntity alarm);

  @Query('DELETE FROM alarms WHERE id = :id')
  Future<void> deleteAlarmById(int id);
}

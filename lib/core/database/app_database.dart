import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/alarm_dao.dart';
import 'dao/customization_dao.dart';
import 'dao/stopwatch_dao.dart';
import 'entities/alarm_entity.dart';
import 'entities/customization_entity.dart';
import 'entities/stopwatch_entity.dart';

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [AlarmEntity, StopwatchSessionEntity, LapEntity, CustomizationEntity],
)
abstract class AppDatabase extends FloorDatabase {
  AlarmDao get alarmDao;
  StopwatchDao get stopwatchDao;
  CustomizationDao get customizationDao;
}

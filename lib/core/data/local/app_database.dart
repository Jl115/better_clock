import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:better_clock/features/alarm/data/dao/alarm_dao.dart';
import 'package:better_clock/features/alarm/data/models/alarm_entity.dart';
import 'package:better_clock/features/customization/data/dao/customization_dao.dart';
import 'package:better_clock/features/customization/data/models/customization_entity.dart';
import 'package:better_clock/features/stopwatch/data/dao/stopwatch_dao.dart';
import 'package:better_clock/features/stopwatch/data/models/stopwatch_entity.dart';

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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AlarmDao? _alarmDaoInstance;

  StopwatchDao? _stopwatchDaoInstance;

  CustomizationDao? _customizationDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `alarms` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `hour` INTEGER NOT NULL, `minute` INTEGER NOT NULL, `repeatDaysJson` TEXT NOT NULL, `label` TEXT NOT NULL, `isEnabled` INTEGER NOT NULL, `soundUri` TEXT, `volume` REAL NOT NULL, `vibrate` INTEGER NOT NULL, `snoozeMinutes` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `stopwatch_sessions` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAtIso` TEXT NOT NULL, `totalDurationMs` INTEGER NOT NULL, `isRunning` INTEGER NOT NULL, `elapsedBeforePauseMs` INTEGER NOT NULL, `lastStartTimeIso` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `laps` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sessionId` INTEGER NOT NULL, `lapNumber` INTEGER NOT NULL, `lapDurationMs` INTEGER NOT NULL, `totalDurationMs` INTEGER NOT NULL, `createdAtIso` TEXT NOT NULL, FOREIGN KEY (`sessionId`) REFERENCES `stopwatch_sessions` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `customization_settings` (`featureKey` TEXT NOT NULL, `settingsJson` TEXT NOT NULL, PRIMARY KEY (`featureKey`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AlarmDao get alarmDao {
    return _alarmDaoInstance ??= _$AlarmDao(database, changeListener);
  }

  @override
  StopwatchDao get stopwatchDao {
    return _stopwatchDaoInstance ??= _$StopwatchDao(database, changeListener);
  }

  @override
  CustomizationDao get customizationDao {
    return _customizationDaoInstance ??=
        _$CustomizationDao(database, changeListener);
  }
}

class _$AlarmDao extends AlarmDao {
  _$AlarmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _alarmEntityInsertionAdapter = InsertionAdapter(
            database,
            'alarms',
            (AlarmEntity item) => <String, Object?>{
                  'id': item.id,
                  'hour': item.hour,
                  'minute': item.minute,
                  'repeatDaysJson': item.repeatDaysJson,
                  'label': item.label,
                  'isEnabled': item.isEnabled ? 1 : 0,
                  'soundUri': item.soundUri,
                  'volume': item.volume,
                  'vibrate': item.vibrate ? 1 : 0,
                  'snoozeMinutes': item.snoozeMinutes
                }),
        _alarmEntityUpdateAdapter = UpdateAdapter(
            database,
            'alarms',
            ['id'],
            (AlarmEntity item) => <String, Object?>{
                  'id': item.id,
                  'hour': item.hour,
                  'minute': item.minute,
                  'repeatDaysJson': item.repeatDaysJson,
                  'label': item.label,
                  'isEnabled': item.isEnabled ? 1 : 0,
                  'soundUri': item.soundUri,
                  'volume': item.volume,
                  'vibrate': item.vibrate ? 1 : 0,
                  'snoozeMinutes': item.snoozeMinutes
                }),
        _alarmEntityDeletionAdapter = DeletionAdapter(
            database,
            'alarms',
            ['id'],
            (AlarmEntity item) => <String, Object?>{
                  'id': item.id,
                  'hour': item.hour,
                  'minute': item.minute,
                  'repeatDaysJson': item.repeatDaysJson,
                  'label': item.label,
                  'isEnabled': item.isEnabled ? 1 : 0,
                  'soundUri': item.soundUri,
                  'volume': item.volume,
                  'vibrate': item.vibrate ? 1 : 0,
                  'snoozeMinutes': item.snoozeMinutes
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AlarmEntity> _alarmEntityInsertionAdapter;

  final UpdateAdapter<AlarmEntity> _alarmEntityUpdateAdapter;

  final DeletionAdapter<AlarmEntity> _alarmEntityDeletionAdapter;

  @override
  Future<List<AlarmEntity>> findAllAlarms() async {
    return _queryAdapter.queryList('SELECT * FROM alarms',
        mapper: (Map<String, Object?> row) => AlarmEntity(
            id: row['id'] as int?,
            hour: row['hour'] as int,
            minute: row['minute'] as int,
            repeatDaysJson: row['repeatDaysJson'] as String,
            label: row['label'] as String,
            isEnabled: (row['isEnabled'] as int) != 0,
            soundUri: row['soundUri'] as String?,
            volume: row['volume'] as double,
            vibrate: (row['vibrate'] as int) != 0,
            snoozeMinutes: row['snoozeMinutes'] as int));
  }

  @override
  Future<List<AlarmEntity>> findEnabledAlarms() async {
    return _queryAdapter.queryList('SELECT * FROM alarms WHERE isEnabled = 1',
        mapper: (Map<String, Object?> row) => AlarmEntity(
            id: row['id'] as int?,
            hour: row['hour'] as int,
            minute: row['minute'] as int,
            repeatDaysJson: row['repeatDaysJson'] as String,
            label: row['label'] as String,
            isEnabled: (row['isEnabled'] as int) != 0,
            soundUri: row['soundUri'] as String?,
            volume: row['volume'] as double,
            vibrate: (row['vibrate'] as int) != 0,
            snoozeMinutes: row['snoozeMinutes'] as int));
  }

  @override
  Future<AlarmEntity?> findAlarmById(int id) async {
    return _queryAdapter.query('SELECT * FROM alarms WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AlarmEntity(
            id: row['id'] as int?,
            hour: row['hour'] as int,
            minute: row['minute'] as int,
            repeatDaysJson: row['repeatDaysJson'] as String,
            label: row['label'] as String,
            isEnabled: (row['isEnabled'] as int) != 0,
            soundUri: row['soundUri'] as String?,
            volume: row['volume'] as double,
            vibrate: (row['vibrate'] as int) != 0,
            snoozeMinutes: row['snoozeMinutes'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteAlarmById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM alarms WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertAlarm(AlarmEntity alarm) {
    return _alarmEntityInsertionAdapter.insertAndReturnId(
        alarm, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAlarm(AlarmEntity alarm) {
    return _alarmEntityUpdateAdapter.updateAndReturnChangedRows(
        alarm, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAlarm(AlarmEntity alarm) {
    return _alarmEntityDeletionAdapter.deleteAndReturnChangedRows(alarm);
  }
}

class _$StopwatchDao extends StopwatchDao {
  _$StopwatchDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _stopwatchSessionEntityInsertionAdapter = InsertionAdapter(
            database,
            'stopwatch_sessions',
            (StopwatchSessionEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAtIso': item.createdAtIso,
                  'totalDurationMs': item.totalDurationMs,
                  'isRunning': item.isRunning ? 1 : 0,
                  'elapsedBeforePauseMs': item.elapsedBeforePauseMs,
                  'lastStartTimeIso': item.lastStartTimeIso
                }),
        _lapEntityInsertionAdapter = InsertionAdapter(
            database,
            'laps',
            (LapEntity item) => <String, Object?>{
                  'id': item.id,
                  'sessionId': item.sessionId,
                  'lapNumber': item.lapNumber,
                  'lapDurationMs': item.lapDurationMs,
                  'totalDurationMs': item.totalDurationMs,
                  'createdAtIso': item.createdAtIso
                }),
        _stopwatchSessionEntityUpdateAdapter = UpdateAdapter(
            database,
            'stopwatch_sessions',
            ['id'],
            (StopwatchSessionEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAtIso': item.createdAtIso,
                  'totalDurationMs': item.totalDurationMs,
                  'isRunning': item.isRunning ? 1 : 0,
                  'elapsedBeforePauseMs': item.elapsedBeforePauseMs,
                  'lastStartTimeIso': item.lastStartTimeIso
                }),
        _stopwatchSessionEntityDeletionAdapter = DeletionAdapter(
            database,
            'stopwatch_sessions',
            ['id'],
            (StopwatchSessionEntity item) => <String, Object?>{
                  'id': item.id,
                  'createdAtIso': item.createdAtIso,
                  'totalDurationMs': item.totalDurationMs,
                  'isRunning': item.isRunning ? 1 : 0,
                  'elapsedBeforePauseMs': item.elapsedBeforePauseMs,
                  'lastStartTimeIso': item.lastStartTimeIso
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StopwatchSessionEntity>
      _stopwatchSessionEntityInsertionAdapter;

  final InsertionAdapter<LapEntity> _lapEntityInsertionAdapter;

  final UpdateAdapter<StopwatchSessionEntity>
      _stopwatchSessionEntityUpdateAdapter;

  final DeletionAdapter<StopwatchSessionEntity>
      _stopwatchSessionEntityDeletionAdapter;

  @override
  Future<List<StopwatchSessionEntity>> findAllSessions() async {
    return _queryAdapter.queryList(
        'SELECT * FROM stopwatch_sessions ORDER BY createdAtIso DESC',
        mapper: (Map<String, Object?> row) => StopwatchSessionEntity(
            id: row['id'] as int?,
            createdAtIso: row['createdAtIso'] as String,
            totalDurationMs: row['totalDurationMs'] as int,
            isRunning: (row['isRunning'] as int) != 0,
            elapsedBeforePauseMs: row['elapsedBeforePauseMs'] as int,
            lastStartTimeIso: row['lastStartTimeIso'] as String?));
  }

  @override
  Future<StopwatchSessionEntity?> findSessionById(int id) async {
    return _queryAdapter.query('SELECT * FROM stopwatch_sessions WHERE id = ?1',
        mapper: (Map<String, Object?> row) => StopwatchSessionEntity(
            id: row['id'] as int?,
            createdAtIso: row['createdAtIso'] as String,
            totalDurationMs: row['totalDurationMs'] as int,
            isRunning: (row['isRunning'] as int) != 0,
            elapsedBeforePauseMs: row['elapsedBeforePauseMs'] as int,
            lastStartTimeIso: row['lastStartTimeIso'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<LapEntity>> findLapsBySessionId(int sessionId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM laps WHERE sessionId = ?1 ORDER BY lapNumber ASC',
        mapper: (Map<String, Object?> row) => LapEntity(
            id: row['id'] as int?,
            sessionId: row['sessionId'] as int,
            lapNumber: row['lapNumber'] as int,
            lapDurationMs: row['lapDurationMs'] as int,
            totalDurationMs: row['totalDurationMs'] as int,
            createdAtIso: row['createdAtIso'] as String),
        arguments: [sessionId]);
  }

  @override
  Future<void> deleteLapsBySessionId(int sessionId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM laps WHERE sessionId = ?1',
        arguments: [sessionId]);
  }

  @override
  Future<int> insertSession(StopwatchSessionEntity session) {
    return _stopwatchSessionEntityInsertionAdapter.insertAndReturnId(
        session, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertLap(LapEntity lap) async {
    await _lapEntityInsertionAdapter.insert(lap, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateSession(StopwatchSessionEntity session) {
    return _stopwatchSessionEntityUpdateAdapter.updateAndReturnChangedRows(
        session, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteSession(StopwatchSessionEntity session) {
    return _stopwatchSessionEntityDeletionAdapter
        .deleteAndReturnChangedRows(session);
  }
}

class _$CustomizationDao extends CustomizationDao {
  _$CustomizationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _customizationEntityInsertionAdapter = InsertionAdapter(
            database,
            'customization_settings',
            (CustomizationEntity item) => <String, Object?>{
                  'featureKey': item.featureKey,
                  'settingsJson': item.settingsJson
                }),
        _customizationEntityUpdateAdapter = UpdateAdapter(
            database,
            'customization_settings',
            ['featureKey'],
            (CustomizationEntity item) => <String, Object?>{
                  'featureKey': item.featureKey,
                  'settingsJson': item.settingsJson
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CustomizationEntity>
      _customizationEntityInsertionAdapter;

  final UpdateAdapter<CustomizationEntity> _customizationEntityUpdateAdapter;

  @override
  Future<CustomizationEntity?> findByFeatureKey(String key) async {
    return _queryAdapter.query(
        'SELECT * FROM customization_settings WHERE featureKey = ?1',
        mapper: (Map<String, Object?> row) => CustomizationEntity(
            featureKey: row['featureKey'] as String,
            settingsJson: row['settingsJson'] as String),
        arguments: [key]);
  }

  @override
  Future<List<CustomizationEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM customization_settings',
        mapper: (Map<String, Object?> row) => CustomizationEntity(
            featureKey: row['featureKey'] as String,
            settingsJson: row['settingsJson'] as String));
  }

  @override
  Future<void> deleteByFeatureKey(String key) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM customization_settings WHERE featureKey = ?1',
        arguments: [key]);
  }

  @override
  Future<void> insertSetting(CustomizationEntity setting) async {
    await _customizationEntityInsertionAdapter.insert(
        setting, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateSetting(CustomizationEntity setting) {
    return _customizationEntityUpdateAdapter.updateAndReturnChangedRows(
        setting, OnConflictStrategy.abort);
  }
}

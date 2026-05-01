import 'package:floor/floor.dart';

@Entity(tableName: 'stopwatch_sessions')
class StopwatchSessionEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String createdAtIso;
  final int totalDurationMs;
  final bool isRunning;
  final int elapsedBeforePauseMs;
  final String? lastStartTimeIso;

  const StopwatchSessionEntity({
    this.id,
    required this.createdAtIso,
    required this.totalDurationMs,
    required this.isRunning,
    required this.elapsedBeforePauseMs,
    this.lastStartTimeIso,
  });

  StopwatchSessionEntity copyWith({
    int? id,
    String? createdAtIso,
    int? totalDurationMs,
    bool? isRunning,
    int? elapsedBeforePauseMs,
    String? lastStartTimeIso,
  }) {
    return StopwatchSessionEntity(
      id: id ?? this.id,
      createdAtIso: createdAtIso ?? this.createdAtIso,
      totalDurationMs: totalDurationMs ?? this.totalDurationMs,
      isRunning: isRunning ?? this.isRunning,
      elapsedBeforePauseMs: elapsedBeforePauseMs ?? this.elapsedBeforePauseMs,
      lastStartTimeIso: lastStartTimeIso ?? this.lastStartTimeIso,
    );
  }
}

@Entity(
  tableName: 'laps',
  foreignKeys: [
    ForeignKey(
      childColumns: ['sessionId'],
      parentColumns: ['id'],
      entity: StopwatchSessionEntity,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class LapEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int sessionId;
  final int lapNumber;
  final int lapDurationMs;
  final int totalDurationMs;
  final String createdAtIso;

  const LapEntity({
    this.id,
    required this.sessionId,
    required this.lapNumber,
    required this.lapDurationMs,
    required this.totalDurationMs,
    required this.createdAtIso,
  });
}

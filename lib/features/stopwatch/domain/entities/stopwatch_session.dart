import 'stopwatch_lap.dart';

/// Pure Dart domain model for a stopwatch session.
/// Contains the aggregate root state: total elapsed time and lap list.
class StopwatchSession {
  final int? id;
  final DateTime createdAt;
  final Duration totalDuration;
  final bool isRunning;
  final Duration elapsedBeforePause;
  final DateTime? lastStartTime;
  final List<StopwatchLap> laps;

  const StopwatchSession({
    this.id,
    required this.createdAt,
    required this.totalDuration,
    required this.isRunning,
    required this.elapsedBeforePause,
    this.lastStartTime,
    required this.laps,
  });

  StopwatchSession copyWith({
    int? id,
    DateTime? createdAt,
    Duration? totalDuration,
    bool? isRunning,
    Duration? elapsedBeforePause,
    DateTime? lastStartTime,
    List<StopwatchLap>? laps,
  }) {
    return StopwatchSession(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      totalDuration: totalDuration ?? this.totalDuration,
      isRunning: isRunning ?? this.isRunning,
      elapsedBeforePause: elapsedBeforePause ?? this.elapsedBeforePause,
      lastStartTime: lastStartTime,
      laps: laps ?? this.laps,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopwatchSession &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          totalDuration == other.totalDuration &&
          isRunning == other.isRunning &&
          elapsedBeforePause == other.elapsedBeforePause &&
          lastStartTime == other.lastStartTime;

  @override
  int get hashCode => Object.hash(id, totalDuration, isRunning, elapsedBeforePause, lastStartTime);
}

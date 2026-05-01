/// Pure Dart domain model for a stopwatch lap.
/// Immutable value object with value equality.
class StopwatchLap {
  final int? id;
  final int sessionId;
  final int lapNumber;
  final Duration lapDuration;
  final Duration totalDuration;
  final DateTime createdAt;

  const StopwatchLap({
    this.id,
    required this.sessionId,
    required this.lapNumber,
    required this.lapDuration,
    required this.totalDuration,
    required this.createdAt,
  });

  StopwatchLap copyWith({
    int? id,
    int? sessionId,
    int? lapNumber,
    Duration? lapDuration,
    Duration? totalDuration,
    DateTime? createdAt,
  }) {
    return StopwatchLap(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      lapNumber: lapNumber ?? this.lapNumber,
      lapDuration: lapDuration ?? this.lapDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopwatchLap &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sessionId == other.sessionId &&
          lapNumber == other.lapNumber &&
          lapDuration == other.lapDuration &&
          totalDuration == other.totalDuration;

  @override
  int get hashCode => Object.hash(id, sessionId, lapNumber, lapDuration, totalDuration);
}

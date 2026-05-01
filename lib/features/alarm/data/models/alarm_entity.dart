import 'package:floor/floor.dart';

@Entity(tableName: 'alarms')
class AlarmEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int hour;
  final int minute;
  final String repeatDaysJson; // e.g., [1,3,5] for Mon,Wed,Fri
  final String label;
  final bool isEnabled;
  final String? soundUri; // null = default
  final double volume;
  final bool vibrate;
  final int snoozeMinutes;

  const AlarmEntity({
    this.id,
    required this.hour,
    required this.minute,
    required this.repeatDaysJson,
    required this.label,
    required this.isEnabled,
    this.soundUri,
    required this.volume,
    required this.vibrate,
    required this.snoozeMinutes,
  });

  AlarmEntity copyWith({
    int? id,
    int? hour,
    int? minute,
    String? repeatDaysJson,
    String? label,
    bool? isEnabled,
    String? soundUri,
    double? volume,
    bool? vibrate,
    int? snoozeMinutes,
  }) {
    return AlarmEntity(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      repeatDaysJson: repeatDaysJson ?? this.repeatDaysJson,
      label: label ?? this.label,
      isEnabled: isEnabled ?? this.isEnabled,
      soundUri: soundUri ?? this.soundUri,
      volume: volume ?? this.volume,
      vibrate: vibrate ?? this.vibrate,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    );
  }
}

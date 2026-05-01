/// Customization settings for the Stopwatch feature.
/// Stored as JSON in the database; deserialized into this object.
class StopwatchCustomization {
  static const String featureKey = 'stopwatch';

  final double digitFontSize;
  final bool showLapList;
  final String lapListPosition; // 'top' or 'bottom'
  final int digitColorHex;
  final int accentColorHex;
  final bool showMilliseconds;

  const StopwatchCustomization({
    this.digitFontSize = 64.0,
    this.showLapList = true,
    this.lapListPosition = 'bottom',
    this.digitColorHex = 0xFFFFFFFF,
    this.accentColorHex = 0xFF9C27B0,
    this.showMilliseconds = true,
  });

  Map<String, dynamic> toJson() => {
    'digitFontSize': digitFontSize,
    'showLapList': showLapList,
    'lapListPosition': lapListPosition,
    'digitColorHex': digitColorHex,
    'accentColorHex': accentColorHex,
    'showMilliseconds': showMilliseconds,
  };

  factory StopwatchCustomization.fromJson(Map<String, dynamic> json) {
    return StopwatchCustomization(
      digitFontSize: (json['digitFontSize'] as num?)?.toDouble() ?? 64.0,
      showLapList: json['showLapList'] as bool? ?? true,
      lapListPosition: json['lapListPosition'] as String? ?? 'bottom',
      digitColorHex: json['digitColorHex'] as int? ?? 0xFFFFFFFF,
      accentColorHex: json['accentColorHex'] as int? ?? 0xFF9C27B0,
      showMilliseconds: json['showMilliseconds'] as bool? ?? true,
    );
  }

  StopwatchCustomization copyWith({
    double? digitFontSize,
    bool? showLapList,
    String? lapListPosition,
    int? digitColorHex,
    int? accentColorHex,
    bool? showMilliseconds,
  }) {
    return StopwatchCustomization(
      digitFontSize: digitFontSize ?? this.digitFontSize,
      showLapList: showLapList ?? this.showLapList,
      lapListPosition: lapListPosition ?? this.lapListPosition,
      digitColorHex: digitColorHex ?? this.digitColorHex,
      accentColorHex: accentColorHex ?? this.accentColorHex,
      showMilliseconds: showMilliseconds ?? this.showMilliseconds,
    );
  }
}

import 'package:floor/floor.dart';

@Entity(tableName: 'customization_settings')
class CustomizationEntity {
  @primaryKey
  final String featureKey;

  final String settingsJson;

  const CustomizationEntity({
    required this.featureKey,
    required this.settingsJson,
  });

  CustomizationEntity copyWith({
    String? featureKey,
    String? settingsJson,
  }) {
    return CustomizationEntity(
      featureKey: featureKey ?? this.featureKey,
      settingsJson: settingsJson ?? this.settingsJson,
    );
  }
}

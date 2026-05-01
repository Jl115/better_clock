import 'package:floor/floor.dart';

import '../models/customization_entity.dart';

@dao
abstract class CustomizationDao {
  @Query('SELECT * FROM customization_settings WHERE featureKey = :key')
  Future<CustomizationEntity?> findByFeatureKey(String key);

  @Query('SELECT * FROM customization_settings')
  Future<List<CustomizationEntity>> findAll();

  @insert
  Future<void> insertSetting(CustomizationEntity setting);

  @update
  Future<int> updateSetting(CustomizationEntity setting);

  @Query('DELETE FROM customization_settings WHERE featureKey = :key')
  Future<void> deleteByFeatureKey(String key);
}

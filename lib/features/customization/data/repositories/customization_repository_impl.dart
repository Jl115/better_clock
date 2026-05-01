import 'dart:convert';

import '../../../../core/data/local/app_database.dart';
import '../models/customization_entity.dart';

import '../../../../core/utils/result.dart';
import '../../../stopwatch/domain/entities/stopwatch_customization.dart';
import '../../domain/repositories/customization_repository.dart';

class CustomizationRepositoryImpl implements ICustomizationRepository {
  final AppDatabase _database;
  const CustomizationRepositoryImpl(this._database);

  @override
  Future<Result<StopwatchCustomization, AppError>> getStopwatchCustomization() async {
    try {
      final entity = await _database.customizationDao
          .findByFeatureKey(StopwatchCustomization.featureKey);
      if (entity == null) {
        return const Success(StopwatchCustomization());
      }
      final json = jsonDecode(entity.settingsJson) as Map<String, dynamic>;
      return Success(StopwatchCustomization.fromJson(json));
    } catch (e) {
      return Failure(DatabaseError('Failed to load customization: $e'));
    }
  }

  @override
  Future<Result<void, AppError>> saveStopwatchCustomization(
    StopwatchCustomization settings,
  ) async {
    try {
      final json = jsonEncode(settings.toJson());
      final entity = CustomizationEntity(
        featureKey: StopwatchCustomization.featureKey,
        settingsJson: json,
      );
      final existing = await _database.customizationDao
          .findByFeatureKey(StopwatchCustomization.featureKey);
      if (existing == null) {
        await _database.customizationDao.insertSetting(entity);
      } else {
        await _database.customizationDao.updateSetting(entity);
      }
      return const Success(null);
    } catch (e) {
      return Failure(DatabaseError('Failed to save customization: $e'));
    }
  }
}

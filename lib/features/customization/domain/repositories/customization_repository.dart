import '../../../../core/utils/result.dart';
import '../../../stopwatch/domain/entities/stopwatch_customization.dart';

/// Repository interface for per-feature customization settings.
abstract class ICustomizationRepository {
  Future<Result<StopwatchCustomization, AppError>> getStopwatchCustomization();
  Future<Result<void, AppError>> saveStopwatchCustomization(StopwatchCustomization settings);
}

import '../../../../core/utils/result.dart';
import '../../../stopwatch/domain/entities/stopwatch_customization.dart';
import '../repositories/customization_repository.dart';

class GetStopwatchCustomizationUseCase {
  final ICustomizationRepository _repository;
  const GetStopwatchCustomizationUseCase(this._repository);

  Future<Result<StopwatchCustomization, AppError>> call() =>
      _repository.getStopwatchCustomization();
}

class SaveStopwatchCustomizationUseCase {
  final ICustomizationRepository _repository;
  const SaveStopwatchCustomizationUseCase(this._repository);

  Future<Result<void, AppError>> call(StopwatchCustomization settings) =>
      _repository.saveStopwatchCustomization(settings);
}

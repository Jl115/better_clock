import 'package:get_it/get_it.dart';

import '../services/audio_service.dart';
import '../services/notification_service.dart';
import '../services/permission_service.dart';
import '../services/time_ticker_service.dart';
import '../database/app_database.dart';
import '../../features/stopwatch/data/datasources/stopwatch_local_datasource.dart';
import '../../features/stopwatch/data/repositories/stopwatch_repository_impl.dart';
import '../../features/stopwatch/domain/repositories/stopwatch_repository.dart';
import '../../features/stopwatch/domain/usecases/stopwatch_usecases.dart';
import '../../features/customization/data/repositories/customization_repository_impl.dart';
import '../../features/customization/domain/repositories/customization_repository.dart';
import '../../features/customization/domain/usecases/customization_usecases.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Services
  getIt.registerSingleton<TimeTickerService>(TimeTickerService());
  getIt.registerSingleton<AudioService>(AudioService());
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<PermissionService>(PermissionService());

  // Database
  final database = await $FloorAppDatabase
      .databaseBuilder('better_clock.db')
      .build();
  getIt.registerSingleton<AppDatabase>(database);

  // Stopwatch
  getIt.registerLazySingleton<StopwatchLocalDataSource>(
    () => StopwatchLocalDataSource(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<IStopwatchRepository>(
    () => StopwatchRepositoryImpl(getIt<StopwatchLocalDataSource>()),
  );
  getIt.registerLazySingleton(() => CreateSessionUseCase(getIt<IStopwatchRepository>()));
  getIt.registerLazySingleton(() => UpdateSessionUseCase(getIt<IStopwatchRepository>()));
  getIt.registerLazySingleton(() => DeleteSessionUseCase(getIt<IStopwatchRepository>()));
  getIt.registerLazySingleton(() => GetOrCreateCurrentSessionUseCase(getIt<IStopwatchRepository>()));
  getIt.registerLazySingleton(() => AddLapUseCase(getIt<IStopwatchRepository>()));
  getIt.registerLazySingleton(() => DeleteLapsUseCase(getIt<IStopwatchRepository>()));

  // Customization
  getIt.registerLazySingleton<ICustomizationRepository>(
    () => CustomizationRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton(() => GetStopwatchCustomizationUseCase(getIt<ICustomizationRepository>()));
  getIt.registerLazySingleton(() => SaveStopwatchCustomizationUseCase(getIt<ICustomizationRepository>()));
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../bloc/stopwatch_bloc.dart';
import '../pages/stopwatch_page.dart';

/// Feature-owned routes for the Stopwatch tab.
final List<GoRoute> stopwatchRoutes = [
  GoRoute(
    path: '/stopwatch',
    builder: (context, state) => BlocProvider(
      create: (context) => StopwatchBloc(
        getOrCreateSession: getIt(),
        updateSession: getIt(),
        addLap: getIt(),
        deleteLaps: getIt(),
        getCustomization: getIt(),
        saveCustomization: getIt(),
        timeTicker: getIt(),
      ),
      child: const StopwatchPage(),
    ),
  ),
];

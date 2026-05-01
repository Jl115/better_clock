import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'shell_navigator.dart';
import '../../features/alarm/presentation/routes/alarm_routes.dart';
import '../../features/stopwatch/presentation/routes/stopwatch_routes.dart';
import '../../features/customization/presentation/routes/customization_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Top-level router that composes feature-owned routes into a shell.
///
/// Deep-links and redirects will be wired here in Phase 4.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/alarm',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(child: ShellNavigator(child: child));
      },
      routes: [
        ...alarmRoutes,
        ...stopwatchRoutes,
        ...customizationRoutes,
      ],
    ),
  ],
);

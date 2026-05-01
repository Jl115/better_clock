import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/di/injection.dart';
import 'features/alarm/presentation/pages/alarm_list_page.dart';
import 'features/stopwatch/presentation/bloc/stopwatch_bloc.dart';
import 'features/stopwatch/presentation/pages/stopwatch_page.dart';
import 'features/customization/presentation/pages/customization_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/alarm',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(child: ScaffoldWithNavBar(child: child));
      },
      routes: [
        GoRoute(
          path: '/alarm',
          builder: (context, state) => const AlarmListPage(),
        ),
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
        GoRoute(
          path: '/customization',
          builder: (context, state) => const CustomizationPage(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    int getCurrentIndex() {
      switch (location) {
        case '/alarm':
          return 0;
        case '/stopwatch':
          return 1;
        case '/customization':
          return 2;
        default:
          return 0;
      }
    }

    void onItemTapped(int index) {
      switch (index) {
        case 0:
          context.go('/alarm');
          break;
        case 1:
          context.go('/stopwatch');
          break;
        case 2:
          context.go('/customization');
          break;
      }
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: getCurrentIndex(),
        onDestinationSelected: onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.alarm), label: 'Alarm'),
          NavigationDestination(icon: Icon(Icons.timer), label: 'Stopwatch'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

import 'package:go_router/go_router.dart';

import '../pages/alarm_list_page.dart';

/// Feature-owned routes for the Alarm tab.
/// Add `/alarm/new`, `/alarm/edit/:id`, etc. here in Phase 3.
final List<GoRoute> alarmRoutes = [
  GoRoute(
    path: '/alarm',
    builder: (context, state) => const AlarmListPage(),
  ),
];

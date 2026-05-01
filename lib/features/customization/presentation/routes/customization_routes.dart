import 'package:go_router/go_router.dart';

import '../pages/customization_page.dart';

/// Feature-owned routes for the Customization / Settings tab.
final List<GoRoute> customizationRoutes = [
  GoRoute(
    path: '/customization',
    builder: (context, state) => const CustomizationPage(),
  ),
];

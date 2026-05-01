import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/catppuccin_colors.dart';
import 'app_tab.dart';

/// Navigation shell that wraps every tab page with the bottom bar.
class ShellNavigator extends StatelessWidget {
  final Widget child;
  const ShellNavigator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentTab = AppTab.fromPath(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CatppuccinMocha.mantle,
          boxShadow: [
            BoxShadow(
              color: CatppuccinMocha.crust.withValues(alpha: 0.6),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: currentTab.index,
          onDestinationSelected: (index) {
            context.go(AppTab.values[index].path);
          },
          backgroundColor: CatppuccinMocha.mantle,
          indicatorColor: CatppuccinMocha.surface0,
          destinations: [
            for (final tab in AppTab.values)
              NavigationDestination(
                icon: Icon(tab.icon),
                label: tab.label,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'core/services/notification_service.dart';
import 'core/services/audio_service.dart';
import 'core/services/time_ticker_service.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize singleton services
  TimeTickerService();
  AudioService().initialize();
  NotificationService().initialize();

  // Initialize DI (get_it)
  await configureDependencies();

  runApp(const BetterClockApp());
}

class BetterClockApp extends StatelessWidget {
  const BetterClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Better Clock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

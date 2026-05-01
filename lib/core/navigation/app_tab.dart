import 'package:flutter/material.dart';

/// The bottom-tab destinations of the app.
enum AppTab {
  alarm('/alarm', Icons.alarm, 'Alarm'),
  stopwatch('/stopwatch', Icons.timer, 'Stopwatch'),
  customization('/customization', Icons.settings, 'Settings');

  final String path;
  final IconData icon;
  final String label;

  const AppTab(this.path, this.icon, this.label);

  static AppTab fromPath(String path) {
    return values.firstWhere(
      (t) => t.path == path,
      orElse: () => AppTab.alarm,
    );
  }
}

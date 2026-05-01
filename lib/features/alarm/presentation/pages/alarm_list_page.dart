import 'package:flutter/material.dart';

import '../../../../core/theme/catppuccin_colors.dart';

class AlarmListPage extends StatelessWidget {
  const AlarmListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarm')),
      body: const Center(
        child: Text(
          'Alarm List - Coming Soon',
          style: TextStyle(color: CatppuccinMocha.subtext0),
        ),
      ),
    );
  }
}
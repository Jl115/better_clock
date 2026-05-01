import 'package:flutter/material.dart';

import '../../../../core/theme/catppuccin_colors.dart';

class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customization')),
      body: const Center(
        child: Text(
          'Customization - Coming Soon',
          style: TextStyle(color: CatppuccinMocha.subtext0),
        ),
      ),
    );
  }
}
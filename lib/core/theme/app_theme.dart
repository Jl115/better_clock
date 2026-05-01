import 'package:flutter/material.dart';

import 'catppuccin_colors.dart';

/// Theme builder for Better Clock.
///
/// Currently provides Catppuccin Mocha (dark) as the sole theme.
/// A Latte (light) variant is prepared for future toggle support.
class AppTheme {
  const AppTheme._();

  /// The default dark theme: Catppuccin Mocha.
  static ThemeData get mocha => _buildMochaTheme();

  static ThemeData _buildMochaTheme() {
    final scheme = ColorScheme.dark(
      primary: CatppuccinMocha.lavender,
      onPrimary: CatppuccinMocha.crust,
      secondary: CatppuccinMocha.mauve,
      onSecondary: CatppuccinMocha.crust,
      surface: CatppuccinMocha.base,
      onSurface: CatppuccinMocha.text,
      surfaceContainerHighest: CatppuccinMocha.mantle,
      surfaceTint: CatppuccinMocha.lavender,
      error: CatppuccinMocha.red,
      onError: CatppuccinMocha.crust,
      outline: CatppuccinMocha.surface1,
      outlineVariant: CatppuccinMocha.surface0,
      inverseSurface: CatppuccinMocha.text,
      onInverseSurface: CatppuccinMocha.base,
      inversePrimary: CatppuccinMocha.lavender,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: CatppuccinMocha.base,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: CatppuccinMocha.base,
        foregroundColor: CatppuccinMocha.text,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: CatppuccinMocha.mantle,
        selectedItemColor: CatppuccinMocha.lavender,
        unselectedItemColor: CatppuccinMocha.overlay0,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: CatppuccinMocha.mantle,
        elevation: 0,
        indicatorColor: CatppuccinMocha.surface0,
        iconTheme: WidgetStateProperty.all(
          const IconThemeData(color: CatppuccinMocha.overlay0),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: CatppuccinMocha.lavender,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: CatppuccinMocha.overlay0,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          );
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: CatppuccinMocha.surface0,
        thickness: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          foregroundColor: CatppuccinMocha.crust,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: CatppuccinMocha.lavender,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: CatppuccinMocha.text,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: CatppuccinMocha.lavender,
        foregroundColor: CatppuccinMocha.crust,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: CatppuccinMocha.text),
        displayMedium: TextStyle(color: CatppuccinMocha.text),
        displaySmall: TextStyle(color: CatppuccinMocha.text),
        headlineLarge: TextStyle(color: CatppuccinMocha.text),
        headlineMedium: TextStyle(color: CatppuccinMocha.text),
        headlineSmall: TextStyle(color: CatppuccinMocha.text),
        titleLarge: TextStyle(color: CatppuccinMocha.text),
        titleMedium: TextStyle(color: CatppuccinMocha.subtext1),
        titleSmall: TextStyle(color: CatppuccinMocha.subtext0),
        bodyLarge: TextStyle(color: CatppuccinMocha.text),
        bodyMedium: TextStyle(color: CatppuccinMocha.subtext1),
        bodySmall: TextStyle(color: CatppuccinMocha.overlay0),
        labelLarge: TextStyle(color: CatppuccinMocha.subtext1),
        labelMedium: TextStyle(color: CatppuccinMocha.subtext0),
        labelSmall: TextStyle(color: CatppuccinMocha.overlay0),
      ),
    );
  }
}

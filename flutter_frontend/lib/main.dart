// Basic Imports
import 'package:flutter/material.dart';

// Screens
import 'package:flutter_frontend/ui/main_screen.dart';

// UI
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_frontend/ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final double borderRadius = 12.0, cardElevation = 8.0;
  static const Color primaryColor = Color(0xFF6D98BA),
      secondaryColor = Color(0xFFC2F9BB),
      tertiaryColor = Color(0xFFE3D0D8);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? light, ColorScheme? dark) {
        ColorScheme lightColorScheme, darkColorScheme;
        AIBackgroundTheme theme = const AIBackgroundTheme();

        if (light != null && dark != null) {
          // We have both color schemes from the system itself
          lightColorScheme = light.harmonized().copyWith();
          lightColorScheme = lightColorScheme.copyWith(
            primary: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
          );
          darkColorScheme = dark.harmonized().copyWith();
          darkColorScheme = darkColorScheme.copyWith(
            primary: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
          );
        } else {
          // Use my own color scheme
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
            brightness: Brightness.light,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: theme.primaryColor,
            secondary: theme.secondaryColor,
            tertiary: theme.tertiaryColor,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: 'AI Background Demo',
          theme: theme.toThemeData(colorScheme: lightColorScheme),
          home: MainScreen(),
        );
      },
    );
  }
}

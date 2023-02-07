// Basic Imports
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

@immutable
class AIBackgroundTheme extends ThemeExtension<AIBackgroundTheme> {
  final Color primaryColor, secondaryColor, tertiaryColor, neutralColor;
  const AIBackgroundTheme({
    this.primaryColor = const Color(0xFF6D98BA),
    this.secondaryColor = const Color(0xFFC2F9BB),
    this.tertiaryColor = const Color(0xFFE3D0D8),
    this.neutralColor = const Color(0xFF72787e),
  });

  TextTheme _textTheme() => TextTheme(
        // Display Fonts
        displayLarge: GoogleFonts.ptSerif(
          height: 64,
          fontSize: 57,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: GoogleFonts.ptSerif(
          height: 52,
          fontSize: 45,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: GoogleFonts.ptSerif(
          height: 44,
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),

        // Headline Font = Display Font
        headlineLarge: GoogleFonts.ptSerif(
          // height: 40,
          fontSize: 32,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: GoogleFonts.ptSerif(
          // height: 36,
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: GoogleFonts.ptSerif(
          // height: 32,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),

        // Title Fonts
        titleLarge: GoogleFonts.firaSansCondensed(
          // height: 28,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: GoogleFonts.firaSansCondensed(
          // height: 24,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.firaSansCondensed(
          // height: 20,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),

        // Label Fonts
        labelLarge: GoogleFonts.firaSansCondensed(
          // height: 20,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: GoogleFonts.firaSansCondensed(
          // height: 16,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.firaSansCondensed(
          // height: 16,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),

        // Body Fonts
        bodyLarge: GoogleFonts.hindVadodara(
          // height: 24,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.hindVadodara(
          // height: 20,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.hindVadodara(
          // height: 16,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      );

  ThemeData toThemeData({ColorScheme? colorScheme}) => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: _textTheme(),
      );

  @override
  ThemeExtension<AIBackgroundTheme> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) =>
      AIBackgroundTheme(
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        tertiaryColor: tertiaryColor ?? this.tertiaryColor,
        neutralColor: neutralColor ?? this.neutralColor,
      );

  @override
  ThemeExtension<AIBackgroundTheme> lerp(
      covariant ThemeExtension<AIBackgroundTheme>? other, double t) {
    if (other is! AIBackgroundTheme) return this;
    return AIBackgroundTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
    );
  }
}

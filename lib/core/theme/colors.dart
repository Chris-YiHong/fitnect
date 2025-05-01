import 'package:flutter/material.dart';

class FitNectColors extends ThemeExtension<FitNectColors> {
  final Color primary;
  final Color onPrimary;

  final Color background;
  final Color onBackground;

  final Color surface;
  final Color onSurface;

  final Color surfaceVariant;
  final Color onSurfaceVariant;

  final Color grey1;
  final Color grey2;
  final Color grey3;
  final Color error;

  // New color properties
  final Color accent;
  final Color secondary;
  final Color neutral;
  final Color neutralGrey;
  final Color neutralBackground;

  const FitNectColors({
    required this.primary,
    required this.onPrimary,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.error,
    required this.grey1,
    required this.grey2,
    required this.grey3,
    this.accent = Colors.transparent,
    this.secondary = Colors.transparent,
    this.neutral = Colors.transparent,
    this.neutralGrey = Colors.transparent,
    this.neutralBackground = Colors.transparent,
  });

  factory FitNectColors.light() => const FitNectColors(
    primary: Color(0xFF1E88E5),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF000000),
    surface: Color(0xFFFAFAFA),
    onSurface: Color(0xFF000000),
    surfaceVariant: Color(
      0xFFE0E0E0,
    ), // Light grey for input fields, cards, etc.
    onSurfaceVariant: Color(
      0xFF757575,
    ), // Medium grey for text on surfaceVariant
    error: Color(0xFFB00020),
    grey1: Color(0xFFBEC1C3),
    grey2: Color(0xFF7D8488),
    grey3: Color(0xFF263238),
    neutralBackground: Color(0xFF111214), // Dark grey #111214
  );

  factory FitNectColors.dark() => const FitNectColors(
    // Colors from the design style image
    primary: Color(0xFFbeef62), // Light green #beef62
    onPrimary: Color(0xFF1f1b2e), // Dark purple-black
    background: Color(0xFF1f1b2e), // Dark purple-black #1f1b2e
    onBackground: Color(0xFFFFFFFF),
    surface: Color(0xFF1f1b2e), // Dark purple-black #1f1b2e
    onSurface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFF2A2639), // Slightly lighter than dark background
    onSurfaceVariant: Color(
      0xFFCCCCCC,
    ), // Light grey for text on dark surfaceVariant
    error: Color(0xFFff5227), // Red #ff5227
    grey1: Color(0xFF626262), // Grey #626262
    grey2: Color(0xFF7D8488),
    grey3: Color(0xFFBEC1C3),
    accent: Color(0xFF6f3afe), // Purple #6f3afe
    secondary: Color(0xFF1f1b2e), // Dark purple-black #1f1b2e
    neutral: Color(0xFFffffff), // White #ffffff
    neutralGrey: Color(0xFF626262), // Grey #626262
    neutralBackground: Color(0xFF111214), // Dark grey #111214
  );

  @override
  ThemeExtension<FitNectColors> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? error,
    Color? grey1,
    Color? grey2,
    Color? grey3,
    Color? accent,
    Color? secondary,
    Color? neutral,
    Color? neutralGrey,
    Color? neutralBackground,
  }) {
    return FitNectColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      error: error ?? this.error,
      grey1: grey1 ?? this.grey1,
      grey2: grey2 ?? this.grey2,
      grey3: grey3 ?? this.grey3,
      accent: accent ?? this.accent,
      secondary: secondary ?? this.secondary,
      neutral: neutral ?? this.neutral,
      neutralGrey: neutralGrey ?? this.neutralGrey,
      neutralBackground: neutralBackground ?? this.neutralBackground,
    );
  }

  @override
  ThemeExtension<FitNectColors> lerp(
    covariant ThemeExtension<FitNectColors>? other,
    double t,
  ) {
    if (other == null || other is! FitNectColors) return this;

    return FitNectColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      error: Color.lerp(error, other.error, t)!,
      grey1: Color.lerp(grey1, other.grey1, t)!,
      grey2: Color.lerp(grey2, other.grey2, t)!,
      grey3: Color.lerp(grey3, other.grey3, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
      neutralGrey: Color.lerp(neutralGrey, other.neutralGrey, t)!,
      neutralBackground:
          Color.lerp(neutralBackground, other.neutralBackground, t)!,
    );
  }
}

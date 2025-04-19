import 'package:flutter/material.dart';

class FitNectTextTheme extends ThemeExtension<FitNectTextTheme> {
  final TextStyle primary;

  const FitNectTextTheme({required this.primary});

  factory FitNectTextTheme.build() => const FitNectTextTheme(
    primary: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF000000),
    ),
  );

  @override
  ThemeExtension<FitNectTextTheme> copyWith({TextStyle? primary}) {
    return FitNectTextTheme(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<FitNectTextTheme> lerp(
    covariant ThemeExtension<FitNectTextTheme>? other,
    double t,
  ) {
    if (other is! FitNectTextTheme) {
      return this;
    }
    return FitNectTextTheme(
      primary: TextStyle.lerp(primary, other.primary, t)!,
    );
  }
}

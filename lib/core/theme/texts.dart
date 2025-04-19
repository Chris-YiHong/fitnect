import 'package:flutter/material.dart';

class FitNectTextTheme extends ThemeExtension<FitNectTextTheme> {
  // Primary text style
  final TextStyle primary;

  // Headings
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle heading4;
  final TextStyle heading5;

  // Body text
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle subtext;

  // Buttons
  final TextStyle buttonMainpage;
  final TextStyle buttonSubpage;
  final TextStyle hyperlink;

  const FitNectTextTheme({
    required this.primary,
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.heading4,
    required this.heading5,
    required this.body1,
    required this.body2,
    required this.subtext,
    required this.buttonMainpage,
    required this.buttonSubpage,
    required this.hyperlink,
  });

  factory FitNectTextTheme.build() => const FitNectTextTheme(
    primary: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF000000),
    ),
    // Headings as shown in design
    heading1: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    heading2: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    heading3: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    heading4: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    heading5: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    // Body text as shown in design
    body1: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    body2: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    subtext: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    // Button text as shown in design
    buttonMainpage: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    buttonSubpage: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    hyperlink: TextStyle(
      fontFamily: 'PTSans',
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  );

  @override
  ThemeExtension<FitNectTextTheme> copyWith({
    TextStyle? primary,
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? heading3,
    TextStyle? heading4,
    TextStyle? heading5,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? subtext,
    TextStyle? buttonMainpage,
    TextStyle? buttonSubpage,
    TextStyle? hyperlink,
  }) {
    return FitNectTextTheme(
      primary: primary ?? this.primary,
      heading1: heading1 ?? this.heading1,
      heading2: heading2 ?? this.heading2,
      heading3: heading3 ?? this.heading3,
      heading4: heading4 ?? this.heading4,
      heading5: heading5 ?? this.heading5,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      subtext: subtext ?? this.subtext,
      buttonMainpage: buttonMainpage ?? this.buttonMainpage,
      buttonSubpage: buttonSubpage ?? this.buttonSubpage,
      hyperlink: hyperlink ?? this.hyperlink,
    );
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
      heading1: TextStyle.lerp(heading1, other.heading1, t)!,
      heading2: TextStyle.lerp(heading2, other.heading2, t)!,
      heading3: TextStyle.lerp(heading3, other.heading3, t)!,
      heading4: TextStyle.lerp(heading4, other.heading4, t)!,
      heading5: TextStyle.lerp(heading5, other.heading5, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      subtext: TextStyle.lerp(subtext, other.subtext, t)!,
      buttonMainpage: TextStyle.lerp(buttonMainpage, other.buttonMainpage, t)!,
      buttonSubpage: TextStyle.lerp(buttonSubpage, other.buttonSubpage, t)!,
      hyperlink: TextStyle.lerp(hyperlink, other.hyperlink, t)!,
    );
  }
}

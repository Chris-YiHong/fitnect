import 'package:fitnect/core/theme/colors.dart';
import 'package:fitnect/core/theme/texts.dart';
import 'package:fitnect/core/theme/theme_data/theme_data.dart';
import 'package:fitnect/core/theme/theme_data/theme_data_factory.dart';
import 'package:flutter/material.dart';

/// This is a uniform theme
/// But you can use it to create multiple themes for iOS, Android, Web, Desktop...
class UniversalThemeFactory extends FitNectThemeDataFactory {
  const UniversalThemeFactory();

  @override
  FitNectThemeData build({
    required FitNectColors colors,
    required FitNectTextTheme defaultTextStyle,
  }) {
    return FitNectThemeData(
      colors: colors,
      defaultTextTheme: defaultTextStyle,
      materialTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'PTSans',
        colorScheme: ColorScheme(
          brightness:
              colors == FitNectColors.dark()
                  ? Brightness.dark
                  : Brightness.light,
          primary: colors.primary,
          onPrimary: colors.onPrimary,
          secondary: colors.accent,
          onSecondary: colors.onSurface,
          error: colors.error,
          onError: colors.neutral,
          background: colors.background,
          onBackground: colors.onBackground,
          surface: colors.surface,
          onSurface: colors.onSurface,
          surfaceVariant: colors.surfaceVariant,
          onSurfaceVariant: colors.onSurfaceVariant,
          tertiary: colors.secondary,
          onTertiary: colors.onSurface,
          outline: colors.grey1,
          shadow: colors.neutralGrey,
        ),
        elevatedButtonTheme: elevatedButtonTheme(
          colors: colors,
          textTheme: defaultTextStyle,
        ),
        outlinedButtonTheme: outlinedButtonTheme(
          colors: colors,
          textTheme: defaultTextStyle,
        ),
        textButtonTheme: textButtonTheme(
          colors: colors,
          textTheme: defaultTextStyle,
        ),
        inputDecorationTheme: inputDecorationTheme(
          colors: colors,
          textTheme: defaultTextStyle,
        ),
        textTheme: textTheme(
          colors: colors,
          defaultTextStyle: defaultTextStyle,
        ),
        navigationRailTheme: navigationRailThemeData(
          colors: colors,
          textTheme: defaultTextStyle,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colors.surface,
          foregroundColor: colors.onSurface,
          elevation: 0,
        ),
        scaffoldBackgroundColor: colors.background,
        cardTheme: CardTheme(
          color: colors.surface,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: colors.grey1,
          thickness: 1,
          space: 1,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: colors.surface,
          disabledColor: colors.grey1,
          selectedColor: colors.primary,
          secondarySelectedColor: colors.accent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          labelStyle: defaultTextStyle.body2,
          secondaryLabelStyle: defaultTextStyle.body2,
          brightness:
              colors == FitNectColors.dark()
                  ? Brightness.dark
                  : Brightness.light,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  NavigationRailThemeData navigationRailThemeData({
    required FitNectColors colors,
    required FitNectTextTheme textTheme,
  }) => NavigationRailThemeData(
    backgroundColor: colors.surface,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: colors.primary),
    unselectedIconTheme: IconThemeData(color: colors.grey2),
    selectedLabelTextStyle: textTheme.body2.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w700,
    ),
    unselectedLabelTextStyle: textTheme.body2.copyWith(
      color: colors.onSurface,
      fontWeight: FontWeight.w700,
    ),
  );

  ElevatedButtonThemeData elevatedButtonTheme({
    required FitNectColors colors,
    required FitNectTextTheme textTheme,
  }) => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(200, 48),
      foregroundColor: colors.onPrimary,
      backgroundColor: colors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: textTheme.buttonMainpage,
      elevation: 0,
    ),
  );

  OutlinedButtonThemeData outlinedButtonTheme({
    required FitNectColors colors,
    required FitNectTextTheme textTheme,
  }) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(200, 48),
      foregroundColor: colors.primary,
      side: BorderSide(color: colors.primary, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: textTheme.buttonSubpage,
    ),
  );

  TextButtonThemeData textButtonTheme({
    required FitNectColors colors,
    required FitNectTextTheme textTheme,
  }) => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colors.accent,
      textStyle: textTheme.hyperlink,
    ),
  );

  InputDecorationTheme inputDecorationTheme({
    required FitNectColors colors,
    required FitNectTextTheme textTheme,
  }) => InputDecorationTheme(
    fillColor: colors.surface,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none, //
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: colors.accent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: colors.error, width: 2),
    ),
    filled: true,
    hintStyle: textTheme.body2.copyWith(color: colors.grey1),
    labelStyle: textTheme.body2.copyWith(color: colors.grey2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: colors.grey2),
    ),
  );

  PageTransitionsTheme get pageTransitionsTheme => const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  TextTheme textTheme({
    required FitNectColors colors,
    required FitNectTextTheme defaultTextStyle,
  }) => TextTheme(
    // Display
    displayLarge: defaultTextStyle.heading1.copyWith(
      color: colors.onBackground,
    ),
    displayMedium: defaultTextStyle.heading2.copyWith(
      color: colors.onBackground,
    ),
    displaySmall: defaultTextStyle.heading3.copyWith(
      color: colors.onBackground,
    ),

    // Headline
    headlineLarge: defaultTextStyle.heading1.copyWith(
      color: colors.onBackground,
    ),
    headlineMedium: defaultTextStyle.heading2.copyWith(
      color: colors.onBackground,
    ),
    headlineSmall: defaultTextStyle.heading3.copyWith(
      color: colors.onBackground,
    ),

    // Title
    titleLarge: defaultTextStyle.heading3.copyWith(color: colors.onBackground),
    titleMedium: defaultTextStyle.heading4.copyWith(color: colors.onBackground),
    titleSmall: defaultTextStyle.heading5.copyWith(color: colors.onBackground),

    // Body
    bodyLarge: defaultTextStyle.body1.copyWith(color: colors.onBackground),
    bodyMedium: defaultTextStyle.body2.copyWith(color: colors.onBackground),
    bodySmall: defaultTextStyle.subtext.copyWith(color: colors.onBackground),

    // Label
    labelLarge: defaultTextStyle.buttonMainpage.copyWith(
      color: colors.onBackground,
    ),
    labelMedium: defaultTextStyle.buttonSubpage.copyWith(
      color: colors.onBackground,
    ),
    labelSmall: defaultTextStyle.hyperlink.copyWith(color: colors.onBackground),
  );
}

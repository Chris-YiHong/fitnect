import 'package:fitnect/core/theme/colors.dart';
import 'package:fitnect/core/theme/texts.dart';
import 'package:fitnect/core/theme/theme_data/theme_data.dart';

/// This is the factory used to create the theme from the colors and textTheme
/// You can create your own factory to create your own theme
/// see universal_theme.dart for an example
abstract class FitNectThemeDataFactory {
  const FitNectThemeDataFactory();

  FitNectThemeData build({
    required FitNectColors colors,
    required FitNectTextTheme defaultTextStyle,
  });
}

import 'package:fitnect/core/theme/colors.dart';
import 'package:fitnect/core/theme/providers/theme_provider.dart';
import 'package:fitnect/core/theme/theme_data/theme_data.dart';
import 'package:flutter/material.dart';

/// This is a convenience extension to access the theme
/// from the BuildContext
/// Instead of calling Theme.of(context) everywhere
/// You can just call context.theme or context.colors...
extension FitNectThemeExt on BuildContext {
  FitNectColors get colors => Theme.of(this).extension<FitNectColors>()!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  Brightness get brightness => Theme.of(this).brightness;

  FitNectThemeData get kitTheme => ThemeProvider.of(this).current.data;
}

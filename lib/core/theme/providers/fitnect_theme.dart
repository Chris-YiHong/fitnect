import 'package:fitnect/core/theme/colors.dart';
import 'package:fitnect/core/theme/texts.dart';
import 'package:fitnect/core/theme/theme_data/theme_data.dart';
import 'package:universal_io/io.dart';

/// This is the the base theme for the app
/// It is used to generate the light and dark themes
sealed class FitNectTheme {
  const FitNectTheme();

  FitNectColors get colors;

  FitNectTextTheme get textTheme;

  FitNectThemeData get data;
}

class FitNectThemeUniform extends FitNectTheme {
  const FitNectThemeUniform(this.data);

  @override
  final FitNectThemeData data;

  @override
  FitNectColors get colors => data.colors;

  @override
  FitNectTextTheme get textTheme => data.defaultTextTheme;
}

/// If you want to have different
/// themes for different platforms
class FitNectThemeAdaptive extends FitNectTheme {
  final FitNectThemeData? ios;
  final FitNectThemeData? android;
  final FitNectThemeData? web;

  const FitNectThemeAdaptive({this.ios, this.android, this.web});

  @override
  FitNectColors get colors {
    if (Platform.isIOS) {
      return ios!.colors;
    } else if (Platform.isAndroid) {
      return android!.colors;
    } else {
      return web!.colors;
    }
  }

  @override
  FitNectTextTheme get textTheme {
    if (Platform.isIOS) {
      return ios!.defaultTextTheme;
    } else if (Platform.isAndroid) {
      return android!.defaultTextTheme;
    } else {
      return web!.defaultTextTheme;
    }
  }

  @override
  FitNectThemeData get data {
    if (Platform.isIOS) {
      return ios!;
    } else if (Platform.isAndroid) {
      return android!;
    } else {
      return web!;
    }
  }
}

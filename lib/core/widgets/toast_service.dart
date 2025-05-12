import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A modern toast service that provides easy-to-use toast notifications
/// throughout the application.
///
/// This service uses fluttertoast package and provides a clean API for
/// displaying success, error, info, and warning toasts.
final toastServiceProvider = Provider<ToastService>((ref) {
  return ToastService();
});

class ToastService {
  /// Shows a success toast notification.
  ///
  /// Example:
  /// ```dart
  /// ref.read(toastServiceProvider).showSuccess('Profile updated successfully');
  /// ```
  Future<bool?> showSuccess(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    double fontSize = 16.0,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  /// Shows an error toast notification.
  ///
  /// Example:
  /// ```dart
  /// ref.read(toastServiceProvider).showError('Failed to connect to server');
  /// ```
  Future<bool?> showError(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    double fontSize = 16.0,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  /// Shows an info toast notification.
  ///
  /// Example:
  /// ```dart
  /// ref.read(toastServiceProvider).showInfo('New updates available');
  /// ```
  Future<bool?> showInfo(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    double fontSize = 16.0,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  /// Shows a warning toast notification.
  ///
  /// Example:
  /// ```dart
  /// ref.read(toastServiceProvider).showWarning('Your subscription is about to expire');
  /// ```
  Future<bool?> showWarning(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    double fontSize = 16.0,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  /// Shows a custom toast notification with specified colors.
  ///
  /// Example:
  /// ```dart
  /// ref.read(toastServiceProvider).showCustom(
  ///   'Feature activated',
  ///   backgroundColor: Colors.purple,
  ///   textColor: Colors.white,
  /// );
  /// ```
  Future<bool?> showCustom(
    String message, {
    required Color backgroundColor,
    required Color textColor,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    double fontSize = 16.0,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  /// Cancels any active toast notifications.
  ///
  /// Example:
  /// ```dart
  /// ref.read(toastServiceProvider).cancel();
  /// ```
  Future<bool?> cancel() {
    return Fluttertoast.cancel();
  }
}

import 'package:fitnect/core/widgets/toast_service.dart';
import 'package:fitnect/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles authentication errors and displays consistent toast messages
///
/// Usage:
/// ```
/// try {
///   // Authentication logic
/// } catch (e) {
///   handleAuthError(ref, e, 'Cannot sign in with Google');
/// }
/// ```
void handleAuthError(WidgetRef ref, dynamic error, String fallbackMessage) {
  // Extract meaningful error message based on error type
  String errorMessage = fallbackMessage;

  if (error is SigninException) {
    // Handle specific error types from the authentication process
    switch (error.code) {
      case 401:
        errorMessage = 'Authentication failed. Please try again.';
        break;
      case 403:
        errorMessage = 'Account access denied.';
        break;
      case 404:
        errorMessage = 'Cannot connect to authentication service.';
        break;
      case 409:
        errorMessage = 'This account is already linked to another user.';
        break;
      case 500:
        errorMessage = 'Server error. Please try again later.';
        break;
      default:
        // Use the error message if available
        errorMessage = error.message ?? errorMessage;
    }
  } else if (error is SignupException) {
    // Handle signup-specific errors
    switch (error.code) {
      case 409:
        errorMessage = 'An account with this email already exists.';
        break;
      default:
        errorMessage = error.message ?? errorMessage;
    }
  } else if (error is RecoverPasswordException) {
    errorMessage = error.message ?? 'Password recovery failed.';
  } else if (error is PhoneAuthException) {
    switch (error.code) {
      case 400:
        errorMessage = 'Invalid phone number format.';
        break;
      case 429:
        errorMessage = 'Too many requests. Please try again later.';
        break;
      default:
        errorMessage = error.message ?? 'Phone authentication failed.';
    }
  }

  // Show user-friendly error toast using our new toast service
  ref.read(toastServiceProvider).showError(errorMessage);
}

import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/models/user.dart';
import 'package:fitnect/core/states/user_state_notifier.dart';
import 'package:fitnect/core/widgets/toast.dart';
import 'package:fitnect/modules/authentication/api/authentication_api_interface.dart';
import 'package:fitnect/modules/authentication/providers/models/phone_signin_state.dart';
import 'package:fitnect/modules/authentication/repositories/authentication_repository.dart';
import 'package:fitnect/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:fitnect/router.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'phone_auth_notifier.g.dart';

/// This notifier is used to handle the phone number authentication flow
/// It is used to send the OTP code to the user's phone number
/// and to verify the OTP code
/// It is also used to link the phone number to the user
/// and to sign in the user with the phone number
///
/// -- if you enable anonymous mode we try to link the user to the phone number
/// -- if it fails we sign in the user with the phone number

@Riverpod(keepAlive: false)
class PhoneAuthNotifier extends _$PhoneAuthNotifier {
  late AuthenticationRepository _authRepository;
  final _logger = Logger();

  @override
  PhoneAuthState build() {
    _authRepository = ref.read(authRepositoryProvider);
    return const PhoneAuthState.inputPhone(linkPhoneToUser: false);
  }

  /// Helper to normalize phone number to E.164 format (prepend + if missing)
  String _normalizePhoneNumber(String phoneNumber) {
    final trimmed = phoneNumber.trim();
    if (trimmed.startsWith('+')) return trimmed;
    // Optionally, you could add logic to infer country code if needed
    return '+$trimmed';
  }

  /// Send the OTP code to the user's phone number
  /// - If the phone number isn't linked to a user, we will link it to the current user
  /// - Otherwise, we will sign in the user with the phone number
  Future<void> sendOtp(String phoneNumber) async {
    if (state.isLoading) {
      return;
    }

    final normalizedPhone = _normalizePhoneNumber(phoneNumber);
    _logger.d("Sending OTP to: $normalizedPhone");

    state = state.copyWith(
      isLoading: true,
      error: null,
      phoneNumber: normalizedPhone,
    );

    try {
      // Get verification ID from repository
      final verificationId = await _authRepository.signinWithPhone(
        normalizedPhone,
      );

      // Update the state with the verification ID to show OTP verification UI
      state = PhoneAuthState.verifyOtp(
        phoneNumber: normalizedPhone,
        verificationId: verificationId,
        linkPhoneToUser: false,
      );

      _logger.d("OTP sent successfully, moved to verification state");

      // We don't need to navigate - the UI will update based on the new state
    } on ApiError catch (e) {
      _logger.e("API error while sending OTP: ${e.message}");
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      _logger.e("Error while sending OTP: $e");
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to send verification code: $e',
      );
    }
  }

  /// Verify the OTP code
  Future<void> verifyOtp(String otp) async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final verificationId = switch (state) {
        PhoneAuthVerifyOtpState(:final verificationId) => verificationId,
        _ => throw Exception("Invalid state: expected OTP verification state"),
      };

      _logger.d("Verifying OTP for verification ID: $verificationId");

      // Call the repository to verify the OTP
      await _authRepository.verifyPhoneAuth(verificationId, otp);

      _logger.d("OTP verification successful!");

      // Show success toast
      ref
          .read(toastProvider)
          .success(
            title: "Success",
            text: "You are now signed in with your phone number",
          );

      // Make sure to set loading to false before navigation
      state = state.copyWith(isLoading: false);

      // Wait a moment before navigation to allow UI to update with success message
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate to home page
      try {
        _logger.d("Navigating to home page after successful verification");
        ref.read(goRouterProvider).go("/home");
      } catch (e) {
        _logger.e("Error navigating to home: $e");
        // Fallback to root if home navigation fails
        ref.read(goRouterProvider).go("/");
      }
    } on ApiError catch (e) {
      _logger.e("API error during OTP verification: ${e.message}");
      final errorMessage = e.message ?? 'Verification failed';
      state = state.copyWith(isLoading: false, error: errorMessage);

      // Show error toast
      ref
          .read(toastProvider)
          .error(title: "Verification Failed", text: errorMessage);
    } catch (e) {
      _logger.e("Error during OTP verification: $e");
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to verify code: $e',
      );

      // Show error toast
      ref
          .read(toastProvider)
          .error(
            title: "Verification Error",
            text: "Failed to verify code. Please try again.",
          );
    }
  }

  /// Reset the state to go back to phone input
  void reset() {
    state = const PhoneAuthState.inputPhone(linkPhoneToUser: false);
  }
}

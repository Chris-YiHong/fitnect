import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/core/widgets/responsive_layout.dart';
import 'package:fitnect/modules/authentication/providers/models/phone_signin_state.dart';
import 'package:fitnect/modules/authentication/providers/phone_auth_notifier.dart';
import 'package:fitnect/modules/authentication/ui/components/otp_verification.dart';
import 'package:fitnect/modules/authentication/ui/components/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Phone Authentication Page that handles both phone number input and OTP verification
/// The page has two states:
/// 1. Phone input - when collecting phone number
/// 2. OTP verification - when verifying the code sent to the phone
class PhoneAuthPage extends ConsumerStatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  ConsumerState<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends ConsumerState<PhoneAuthPage>
    with WidgetsBindingObserver {
  final _logger = Logger();
  bool _isInReCaptchaFlow = false;

  @override
  void initState() {
    super.initState();
    _logger.d("PhoneAuthPage initialized");
    WidgetsBinding.instance.addObserver(this);

    // Reset to phone input state whenever page is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(phoneAuthNotifierProvider.notifier).reset();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logger.d("App lifecycle state changed: $state");

    if (state == AppLifecycleState.paused) {
      // App is entering background, likely for reCAPTCHA
      _isInReCaptchaFlow = true;
      _logger.d("App paused, possibly for reCAPTCHA");
    } else if (state == AppLifecycleState.resumed && _isInReCaptchaFlow) {
      // App is coming back from reCAPTCHA
      _isInReCaptchaFlow = false;
      _logger.d("App resumed from reCAPTCHA flow");

      // Check if we're in the right state
      final currentState = ref.read(phoneAuthNotifierProvider);
      if (currentState is PhoneAuthVerifyOtpState) {
        _logger.d(
          "Successfully transitioned to OTP verification state after reCAPTCHA",
        );
      } else {
        _logger.w("Resumed but not in OTP state: ${currentState.runtimeType}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phoneAuthNotifierProvider);
    _logger.d("Building PhoneAuthPage with state: ${state.runtimeType}");

    return WillPopScope(
      onWillPop: () async {
        if (state is PhoneAuthVerifyOtpState) {
          // If in OTP verification state, go back to phone input instead of popping page
          ref.read(phoneAuthNotifierProvider.notifier).reset();
          return false;
        }
        // Otherwise allow normal back button behavior
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: context.colors.background,
          appBar: AppBar(
            title: Text(
              state is PhoneAuthVerifyOtpState
                  ? 'Verify OTP'
                  : 'Phone Authentication',
            ),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (state is PhoneAuthVerifyOtpState) {
                  // Go back to phone input
                  ref.read(phoneAuthNotifierProvider.notifier).reset();
                } else {
                  // Go back to previous screen
                  Navigator.of(context).pop();
                }
              },
            ),
            actions: [
              // Add help button
              IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () {
                  _showHelpDialog(context, state);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: LargeLayoutContainer(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        state is PhoneAuthVerifyOtpState
                            ? const OtpVerificationComponent()
                            : const PhoneInputComponent(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context, PhoneAuthState state) {
    final title =
        state is PhoneAuthVerifyOtpState
            ? "OTP Verification Help"
            : "Phone Authentication Help";

    final content =
        state is PhoneAuthVerifyOtpState
            ? "Enter the 6-digit code sent to your phone number. "
                "If you didn't receive the code, you can request a new one by tapping 'Resend Code'."
            : "Enter your phone number including country code (e.g., +60 for Malaysia). "
                "We'll send a verification code to this number to verify your identity.";

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _logger.d("PhoneAuthPage disposed");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

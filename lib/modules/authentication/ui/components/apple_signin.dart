// ignore_for_file: use_build_context_synchronously

import 'package:fitnect/modules/authentication/providers/signin_state_provider.dart';
import 'package:fitnect/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:fitnect/modules/authentication/ui/widgets/round_signin.dart';
import 'package:fitnect/modules/authentication/utils/error_handlers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppleSigninComponent extends ConsumerWidget {
  const AppleSigninComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialSigninButton.apple(() async {
      try {
        await ref.read(signinStateProvider.notifier).signinWithApple();
        context.pushReplacement('/');
      } catch (e) {
        // Use the utility function to handle errors consistently
        handleAuthError(ref, e, 'Cannot sign in with Apple');
      }
    });
  }
}

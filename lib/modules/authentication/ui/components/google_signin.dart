// ignore_for_file: use_build_context_synchronously

import 'package:fitnect/modules/authentication/providers/signin_state_provider.dart';
import 'package:fitnect/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:fitnect/modules/authentication/ui/widgets/round_signin.dart';
import 'package:fitnect/modules/authentication/utils/error_handlers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInComponent extends ConsumerWidget {
  const GoogleSignInComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialSigninButton.google(() async {
      try {
        // Get the authentication result
        final result =
            await ref.read(signinStateProvider.notifier).signinWithGoogle();

        // Navigate based on whether the user is new
        if (result.isNewUser) {
          // New user - send to onboarding flow
          context.goNamed('signupOnboarding', pathParameters: {'step': 'name'});
        } else {
          // Existing user - send to home
          context.goNamed('home');
        }
      } catch (e) {
        // Use the utility function to handle errors consistently
        handleAuthError(ref, e, 'Cannot sign in with Google');
      }
    });
  }
}

class GooglePlayGamesSignInComponent extends ConsumerWidget {
  const GooglePlayGamesSignInComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialSigninButton.googlePlayGames(() async {
      try {
        final result =
            await ref.read(signinStateProvider.notifier).signinWithGoogle();

        if (result.isNewUser) {
          context.goNamed('signupOnboarding', pathParameters: {'step': 'name'});
        } else {
          context.goNamed('home');
        }
      } catch (e) {
        // Use the utility function to handle errors consistently
        handleAuthError(ref, e, 'Cannot sign in with Google Play');
      }
    });
  }
}

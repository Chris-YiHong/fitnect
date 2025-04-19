// ignore_for_file: use_build_context_synchronously

import 'package:fitnect/core/widgets/toast.dart';
import 'package:fitnect/modules/authentication/providers/signin_state_provider.dart';
import 'package:fitnect/modules/authentication/ui/widgets/round_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FacebookSigninComponent extends ConsumerWidget {
  const FacebookSigninComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialSigninButton.facebook(
      () => ref
          .read(signinStateProvider.notifier)
          .signinWithFacebook()
          .catchError(
            (err) => showErrorToast(
              context: context,
              title: 'Error',
              text: 'Cannot signin with facebook',
            ),
          )
          .then((value) => context.pushReplacement('/')),
    );
  }
}

import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/core/widgets/buttons.dart';
import 'package:fitnect/core/widgets/page_background.dart';
import 'package:fitnect/core/widgets/toast.dart';
import 'package:fitnect/modules/authentication/providers/models/email.dart';
import 'package:fitnect/modules/authentication/providers/models/password.dart';
import 'package:fitnect/modules/authentication/providers/models/signin_state.dart';
import 'package:fitnect/modules/authentication/providers/signin_state_provider.dart';
import 'package:fitnect/modules/authentication/ui/components/apple_signin.dart';
import 'package:fitnect/modules/authentication/ui/components/facebook_signin.dart';
import 'package:fitnect/modules/authentication/ui/components/google_signin.dart';
import 'package:fitnect/modules/authentication/ui/widgets/round_signin.dart';
import 'package:fitnect/modules/authentication/ui/widgets/signin_header.dart';
import 'package:fitnect/modules/authentication/ui/widgets/social_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_io/io.dart';
import 'package:fitnect/core/widgets/labeled_text_form_field.dart';

final _formKey = GlobalKey<FormState>();

class SigninPage extends ConsumerWidget {
  final bool canDismiss;

  const SigninPage({super.key, this.canDismiss = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signinStateProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        child: PopScope(
          canPop: canDismiss,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 18),
                    const SigninHeader(),
                    const SizedBox(height: 40),
                    LabeledTextFormField(
                      key: const Key('email_input'),
                      onChanged:
                          (value) => ref
                              .read(signinStateProvider.notifier)
                              .setEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        try {
                          state.email.validate();
                        } on EmailException catch (e) {
                          return e.message;
                        }
                        return null;
                      },
                      title: 'Email',
                      hintText: 'bruce@wayne.com',
                    ),
                    const SizedBox(height: 12),
                    LabeledTextFormField(
                      key: const Key('password_input'),
                      onChanged:
                          (newValue) => ref
                              .read(signinStateProvider.notifier)
                              .setPassword(newValue),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      validator: (value) {
                        try {
                          state.password.validate();
                        } on PasswordException catch (e) {
                          return e.message;
                        }
                        return null;
                      },
                      title: 'Password',
                      hintText: 'Password',
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.push('/recover_password');
                        },
                        child: Text(
                          "Forget your password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: context.colors.grey1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      key: const Key('send_button'),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        // hide keyboard
                        FocusScope.of(context).unfocus();
                        ref
                            .read(signinStateProvider.notifier)
                            .signin()
                            .then(
                              // ignore: use_build_context_synchronously
                              (value) => context.go('/'),
                              onError:
                                  (err) => showErrorToast(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    title: 'Error',
                                    text:
                                        'Wrong email, password or this email is not registered',
                                  ),
                            );
                      },
                      child: switch (state) {
                        SigninStateData() => const Text('Sign In'),
                        SigninStateSending() => const ButtonLoading(),
                      },
                    ),
                    const SizedBox(height: 4),
                    TextButton(
                      onPressed: () {
                        context.pushReplacement('/signup');
                      },
                      child: Text(
                        "Don't have an account?",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.neutral,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const SocialSeparator(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (Platform.isIOS) ...const [
                          AppleSigninComponent(),
                        ] else ...const [GoogleSignInComponent()],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

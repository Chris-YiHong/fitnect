import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SigninHeader extends StatelessWidget {
  const SigninHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context).auth.signin_header;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/fitnect_logo_mascot.png',
          width: 120,
          height: 120,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translations.welcome_back,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colors.primary,
              ),
            ),
            Text(
              translations.sign_in_to,
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colors.neutral,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

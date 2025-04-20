import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/i18n/translations.g.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingGender extends ConsumerWidget {
  const OnboardingGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(onboardingFormNotifierProvider).gender;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          t.signup_onboarding.gender.title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        _buildGenderOption(
          context,
          t.signup_onboarding.gender.male,
          Gender.male,
          selectedGender,
          ref,
        ),
        const SizedBox(height: 20),
        _buildGenderOption(
          context,
          t.signup_onboarding.gender.female,
          Gender.female,
          selectedGender,
          ref,
        ),
        const SizedBox(height: 20),
        _buildGenderOption(
          context,
          t.signup_onboarding.gender.other,
          Gender.other,
          selectedGender,
          ref,
        ),
        const SizedBox(height: 20),
        _buildGenderOption(
          context,
          t.signup_onboarding.gender.prefer_not_to_say,
          Gender.preferNotToSay,
          selectedGender,
          ref,
        ),
      ],
    );
  }

  Widget _buildGenderOption(
    BuildContext context,
    String label,
    Gender gender,
    Gender? selectedGender,
    WidgetRef ref,
  ) {
    final isSelected = selectedGender == gender;

    return InkWell(
      onTap: () {
        ref.read(onboardingFormNotifierProvider.notifier).updateGender(gender);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? context.colors.primary
                  : context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSelected ? context.colors.onPrimary : Colors.transparent,
                border:
                    isSelected
                        ? null
                        : Border.all(
                          color: context.colors.onSurface.withOpacity(0.5),
                          width: 2,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

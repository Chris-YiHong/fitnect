import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingActivity extends ConsumerWidget {
  const OnboardingActivity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedActivity =
        ref.watch(onboardingFormNotifierProvider).activityLevel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          "What's your activity level?",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Select the option that best describes your daily activity",
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.onBackground.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        _buildActivityOption(
          context,
          'Sedentary',
          'Little to no exercise, desk job',
          ActivityLevel.sedentary,
          selectedActivity,
          ref,
        ),
        const SizedBox(height: 16),
        _buildActivityOption(
          context,
          'Light',
          'Light exercise 1-3 days/week',
          ActivityLevel.light,
          selectedActivity,
          ref,
        ),
        const SizedBox(height: 16),
        _buildActivityOption(
          context,
          'Moderate',
          'Moderate exercise 3-5 days/week',
          ActivityLevel.moderate,
          selectedActivity,
          ref,
        ),
        const SizedBox(height: 16),
        _buildActivityOption(
          context,
          'Active',
          'Hard exercise 6-7 days/week',
          ActivityLevel.active,
          selectedActivity,
          ref,
        ),
        const SizedBox(height: 16),
        _buildActivityOption(
          context,
          'Very Active',
          'Hard daily exercise and physical job',
          ActivityLevel.veryActive,
          selectedActivity,
          ref,
        ),
      ],
    );
  }

  Widget _buildActivityOption(
    BuildContext context,
    String title,
    String description,
    ActivityLevel level,
    ActivityLevel? selectedLevel,
    WidgetRef ref,
  ) {
    final isSelected = selectedLevel == level;

    return InkWell(
      onTap: () {
        ref
            .read(onboardingFormNotifierProvider.notifier)
            .updateActivityLevel(level);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? context.colors.primary.withOpacity(0.2)
                  : context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? context.colors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Radio<ActivityLevel>(
              value: level,
              groupValue: selectedLevel,
              onChanged: (value) {
                if (value != null) {
                  ref
                      .read(onboardingFormNotifierProvider.notifier)
                      .updateActivityLevel(value);
                }
              },
              activeColor: context.colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

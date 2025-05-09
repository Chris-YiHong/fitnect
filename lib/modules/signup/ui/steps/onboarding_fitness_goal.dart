import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/i18n/translations.g.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingFitnessGoal extends ConsumerWidget {
  const OnboardingFitnessGoal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGoals =
        ref.watch(onboardingFormNotifierProvider).fitnessGoals;
    final t = Translations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              t.signup_onboarding.fitness_goal.title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              t.signup_onboarding.fitness_goal.subtitle,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.onBackground.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildGoalOption(
              context,
              t.signup_onboarding.fitness_goal.lose_weight,
              FitnessGoal.loseWeight,
              selectedGoals,
              ref,
            ),
            const SizedBox(height: 12),
            _buildGoalOption(
              context,
              t.signup_onboarding.fitness_goal.gain_muscle,
              FitnessGoal.gainMuscle,
              selectedGoals,
              ref,
            ),
            const SizedBox(height: 12),
            _buildGoalOption(
              context,
              t.signup_onboarding.fitness_goal.improve_fitness,
              FitnessGoal.improveFitness,
              selectedGoals,
              ref,
            ),
            const SizedBox(height: 12),
            _buildGoalOption(
              context,
              t.signup_onboarding.fitness_goal.increase_endurance,
              FitnessGoal.increaseEndurance,
              selectedGoals,
              ref,
            ),
            const SizedBox(height: 12),
            _buildGoalOption(
              context,
              t.signup_onboarding.fitness_goal.improve_flexibility,
              FitnessGoal.improveFlexibility,
              selectedGoals,
              ref,
            ),
            const SizedBox(height: 12),
            _buildGoalOption(
              context,
              t.signup_onboarding.fitness_goal.other,
              FitnessGoal.other,
              selectedGoals,
              ref,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalOption(
    BuildContext context,
    String label,
    FitnessGoal goal,
    List<FitnessGoal> selectedGoals,
    WidgetRef ref,
  ) {
    final isSelected = selectedGoals.contains(goal);

    return InkWell(
      onTap: () {
        ref
            .read(onboardingFormNotifierProvider.notifier)
            .toggleFitnessGoal(goal);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? context.colors.accent.withOpacity(0.2)
                  : context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? context.colors.accent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colors.onSurface,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color:
                  isSelected
                      ? context.colors.accent
                      : context.colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

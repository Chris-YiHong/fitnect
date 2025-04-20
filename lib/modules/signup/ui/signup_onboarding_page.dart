import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/i18n/translations.g.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_activity.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_birthday.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_completed.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_diet.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_fitness_goal.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_gender.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_health_condition.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_height.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_injuries_history.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_name.dart';
import 'package:fitnect/modules/signup/ui/steps/onboarding_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpOnboardingPage extends ConsumerWidget {
  final String step;

  const SignUpOnboardingPage({super.key, required this.step});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingFormNotifierProvider.notifier);
    final progress = notifier.getProgress(step);

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:
            step != 'name'
                ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: context.colors.onBackground,
                  ),
                  onPressed: () => _navigateToPreviousStep(context),
                )
                : null,
      ),
      body: SafeArea(
        top: step == 'name',
        child: Column(
          children: [
            _buildHeader(context),
            _buildProgressIndicator(context, progress),
            Expanded(child: _OnboardingContent(step: step)),
            _buildBottomButton(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              t.signup_onboarding.header.title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: context.colors.surfaceVariant,
        color: context.colors.primary,
        minHeight: 8,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final notifier = ref.read(onboardingFormNotifierProvider.notifier);
    final model = ref.watch(onboardingFormNotifierProvider);
    final isLastStep = step == 'completed';
    final buttonText =
        isLastStep
            ? t.signup_onboarding.navigation.get_started
            : t.signup_onboarding.navigation.next;
    final isValid = notifier.isStepValid(step);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ElevatedButton(
        onPressed:
            isValid ? () => _navigateToNextStep(context, notifier) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          disabledBackgroundColor: context.colors.surfaceVariant,
          disabledForegroundColor: context.colors.onSurfaceVariant,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          buttonText,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _navigateToNextStep(
    BuildContext context,
    OnboardingFormNotifier notifier,
  ) {
    final nextStep = notifier.getNextStep(step);
    if (nextStep != null) {
      context.goNamed('signupOnboarding', pathParameters: {'step': nextStep});
    } else {
      // Handle completion, e.g., navigate to home
      context.goNamed('home');
    }
  }

  void _navigateToPreviousStep(BuildContext context) {
    final notifier = ProviderScope.containerOf(
      context,
    ).read(onboardingFormNotifierProvider.notifier);
    final previousStep = notifier.getPreviousStep(step);
    if (previousStep != null) {
      context.goNamed(
        'signupOnboarding',
        pathParameters: {'step': previousStep},
      );
    } else {
      context.pop();
    }
  }
}

class _OnboardingContent extends StatelessWidget {
  final String step;

  const _OnboardingContent({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: _buildStepContent(),
    );
  }

  Widget _buildStepContent() {
    switch (step) {
      case 'name':
        return const OnboardingName();
      case 'gender':
        return const OnboardingGender();
      case 'birthday':
        return const OnboardingBirthday();
      case 'height':
        return const OnboardingHeight();
      case 'weight':
        return const OnboardingWeight();
      case 'fitness-goal':
        return const OnboardingFitnessGoal();
      case 'activity':
        return const OnboardingActivity();
      case 'diet':
        return const OnboardingDiet();
      case 'injuries-history':
        return const OnboardingInjuriesHistory();
      case 'health-condition':
        return const OnboardingHealthCondition();
      case 'completed':
        return const OnboardingCompleted();
      default:
        return Center(
          child: Builder(
            builder: (context) {
              final t = Translations.of(context);
              return Text(t.signup_onboarding.unknown_step(step: step));
            },
          ),
        );
    }
  }
}

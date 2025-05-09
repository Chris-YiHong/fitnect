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
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/rendering.dart';

enum OnboardingStep {
  name,
  gender,
  birthday,
  height,
  weight,
  fitnessGoal,
  activity,
  diet,
  injuriesHistory,
  healthCondition,
  completed;

  String get routeName {
    return switch (this) {
      OnboardingStep.name => 'name',
      OnboardingStep.gender => 'gender',
      OnboardingStep.birthday => 'birthday',
      OnboardingStep.height => 'height',
      OnboardingStep.weight => 'weight',
      OnboardingStep.fitnessGoal => 'fitness-goal',
      OnboardingStep.activity => 'activity',
      OnboardingStep.diet => 'diet',
      OnboardingStep.injuriesHistory => 'injuries-history',
      OnboardingStep.healthCondition => 'health-condition',
      OnboardingStep.completed => 'completed',
    };
  }

  static OnboardingStep fromRouteName(String routeName) {
    return switch (routeName) {
      'name' => OnboardingStep.name,
      'gender' => OnboardingStep.gender,
      'birthday' => OnboardingStep.birthday,
      'height' => OnboardingStep.height,
      'weight' => OnboardingStep.weight,
      'fitness-goal' => OnboardingStep.fitnessGoal,
      'activity' => OnboardingStep.activity,
      'diet' => OnboardingStep.diet,
      'injuries-history' => OnboardingStep.injuriesHistory,
      'health-condition' => OnboardingStep.healthCondition,
      'completed' => OnboardingStep.completed,
      _ => throw ArgumentError('Invalid route name: $routeName'),
    };
  }
}

class SignUpOnboardingPage extends ConsumerWidget {
  final OnboardingStep step;

  const SignUpOnboardingPage({super.key, required this.step});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingFormNotifierProvider.notifier);
    final progress = notifier.getProgress(step.routeName);

    return Scaffold(
      backgroundColor: context.colors.neutralBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:
            step != OnboardingStep.name
                ? IconButton(
                  icon: Icon(Icons.arrow_back, color: context.colors.neutral),
                  onPressed: () => _navigateToPreviousStep(context),
                )
                : null,
      ),
      body: SafeArea(
        top: step == OnboardingStep.name,
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildProgressIndicator(context, progress),
            const SizedBox(height: 24),
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
      child: Column(
        children: [
          _buildStyledTitle(context, t.signup_onboarding.header.title),
          Text(
            t.signup_onboarding.header.subtitle,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.neutral,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledTitle(BuildContext context, String title) {
    // Style the "Nect" part of "FitNect" with accent color
    const String brandName = 'FitNect';
    const String stylePart = 'Nect';

    final int brandIndex = title.indexOf(brandName);
    if (brandIndex < 0) {
      // Fallback if brand name isn't found
      return Text(
        title,
        textAlign: TextAlign.center,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.colors.neutral,
        ),
      );
    }

    // Calculate indices for styling
    final int styleStartIndex = brandIndex + brandName.indexOf(stylePart);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.colors.neutral,
        ),
        children: [
          TextSpan(text: title.substring(0, styleStartIndex)),
          TextSpan(
            text: stylePart,
            style: TextStyle(color: context.colors.accent),
          ),
          if (styleStartIndex + stylePart.length < title.length)
            TextSpan(text: title.substring(styleStartIndex + stylePart.length)),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: context.colors.neutral,
        color: context.colors.accent,
        minHeight: 8,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final notifier = ref.read(onboardingFormNotifierProvider.notifier);

    // Watch only the validity state rather than the entire model
    final isValid = ref.watch(
      onboardingFormNotifierProvider.select(
        (model) => model.isStepValid(step.routeName),
      ),
    );

    final isLastStep = step == OnboardingStep.completed;
    final buttonText =
        isLastStep
            ? t.signup_onboarding.navigation.get_started
            : t.signup_onboarding.navigation.next;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ElevatedButton(
        onPressed:
            isValid ? () => _navigateToNextStep(context, notifier) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.accent,
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
    final nextStepName = notifier.getNextStep(step.routeName);
    if (nextStepName != null) {
      context.goNamed(
        'signupOnboarding',
        pathParameters: {'step': nextStepName},
      );
    } else {
      // Handle completion, e.g., navigate to home
      context.goNamed('home');
    }
  }

  void _navigateToPreviousStep(BuildContext context) {
    final notifier = ProviderScope.containerOf(
      context,
    ).read(onboardingFormNotifierProvider.notifier);
    final previousStepName = notifier.getPreviousStep(step.routeName);
    if (previousStepName != null) {
      context.goNamed(
        'signupOnboarding',
        pathParameters: {'step': previousStepName},
      );
    } else {
      context.pop();
    }
  }
}

class _OnboardingContent extends StatelessWidget {
  final OnboardingStep step;

  const _OnboardingContent({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: _buildStepContent(),
    );
  }

  Widget _buildStepContent() {
    return switch (step) {
      OnboardingStep.name => const OnboardingName(),
      OnboardingStep.gender => const OnboardingGender(),
      OnboardingStep.birthday => const OnboardingBirthday(),
      OnboardingStep.height => const OnboardingHeight(),
      OnboardingStep.weight => const OnboardingWeight(),
      OnboardingStep.fitnessGoal => const OnboardingFitnessGoal(),
      OnboardingStep.activity => const OnboardingActivity(),
      OnboardingStep.diet => const OnboardingDiet(),
      OnboardingStep.injuriesHistory => const OnboardingInjuriesHistory(),
      OnboardingStep.healthCondition => const OnboardingHealthCondition(),
      OnboardingStep.completed => const OnboardingCompleted(),
    };
  }
}

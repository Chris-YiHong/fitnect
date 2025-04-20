import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:fitnect/modules/signup/domain/provider/onboarding_submission_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingCompleted extends ConsumerStatefulWidget {
  const OnboardingCompleted({super.key});

  @override
  ConsumerState<OnboardingCompleted> createState() =>
      _OnboardingCompletedState();
}

class _OnboardingCompletedState extends ConsumerState<OnboardingCompleted> {
  @override
  void initState() {
    super.initState();

    // Auto-submit data when reaching this step
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(onboardingSubmissionNotifierProvider.notifier)
          .submitOnboardingData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(onboardingFormNotifierProvider);
    final submissionStatus = ref.watch(onboardingSubmissionNotifierProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          if (submissionStatus == SubmissionStatus.submitting)
            const CircularProgressIndicator()
          else if (submissionStatus == SubmissionStatus.error)
            _buildErrorState(context)
          else
            Icon(
              Icons.check_circle_outline_rounded,
              color: context.colors.primary,
              size: 100,
            ),
          const SizedBox(height: 24),
          Text(
            _getHeadlineText(submissionStatus),
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            _getSubtitleText(submissionStatus),
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onBackground.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          if (submissionStatus == SubmissionStatus.success)
            _buildSummary(context, formData),
          if (submissionStatus == SubmissionStatus.error)
            _buildRetryButton(context),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Icon(
      Icons.error_outline_rounded,
      color: context.colors.error,
      size: 100,
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(onboardingSubmissionNotifierProvider.notifier)
            .submitOnboardingData();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'Retry',
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getHeadlineText(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.submitting:
        return 'Processing...';
      case SubmissionStatus.success:
        return "You're all set!";
      case SubmissionStatus.error:
        return 'Something went wrong';
      default:
        return 'Preparing your profile';
    }
  }

  String _getSubtitleText(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.submitting:
        return 'We are setting up your profile...';
      case SubmissionStatus.success:
        return "Thank you for providing your information. We're excited to start your fitness journey!";
      case SubmissionStatus.error:
        return "We couldn't complete your registration. Please try again.";
      default:
        return 'Just a moment while we prepare everything...';
    }
  }

  Widget _buildSummary(BuildContext context, OnboardingFormModel formData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Profile Summary',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryItem(context, 'Name', formData.name ?? 'Not provided'),
          _buildSummaryItem(context, 'Gender', _formatGender(formData.gender)),
          _buildSummaryItem(context, 'Age', _calculateAge(formData.birthDate)),
          if (formData.heightCm != null)
            _buildSummaryItem(
              context,
              'Height',
              '${formData.heightCm?.toInt()} cm',
            ),
          if (formData.weightKg != null)
            _buildSummaryItem(
              context,
              'Weight',
              '${formData.weightKg?.toInt()} kg',
            ),
          if (formData.fitnessGoals.isNotEmpty)
            _buildSummaryItem(
              context,
              'Goals',
              _formatGoals(formData.fitnessGoals),
            ),
          if (formData.activityLevel != null)
            _buildSummaryItem(
              context,
              'Activity',
              _formatActivity(formData.activityLevel),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatGender(Gender? gender) {
    if (gender == null) return 'Not provided';
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }

  String _calculateAge(DateTime? birthDate) {
    if (birthDate == null) return 'Not provided';
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return '$age years';
  }

  String _formatGoals(List<FitnessGoal> goals) {
    if (goals.isEmpty) return 'Not provided';
    return goals
        .map((goal) {
          switch (goal) {
            case FitnessGoal.loseWeight:
              return 'Lose Weight';
            case FitnessGoal.gainMuscle:
              return 'Gain Muscle';
            case FitnessGoal.improveFitness:
              return 'Improve Fitness';
            case FitnessGoal.increaseEndurance:
              return 'Increase Endurance';
            case FitnessGoal.improveFlexibility:
              return 'Improve Flexibility';
            case FitnessGoal.other:
              return 'Other';
          }
        })
        .join(', ');
  }

  String _formatActivity(ActivityLevel? level) {
    if (level == null) return 'Not provided';
    switch (level) {
      case ActivityLevel.sedentary:
        return 'Sedentary';
      case ActivityLevel.light:
        return 'Light';
      case ActivityLevel.moderate:
        return 'Moderate';
      case ActivityLevel.active:
        return 'Active';
      case ActivityLevel.veryActive:
        return 'Very Active';
    }
  }
}

import 'package:fitnect/modules/signup/domain/provider/onboarding_form_provider.dart';
import 'package:fitnect/modules/signup/repositories/signup_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_submission_provider.g.dart';

enum SubmissionStatus { initial, submitting, success, error }

@riverpod
class OnboardingSubmissionNotifier extends _$OnboardingSubmissionNotifier {
  @override
  SubmissionStatus build() {
    return SubmissionStatus.initial;
  }

  Future<void> submitOnboardingData() async {
    if (state == SubmissionStatus.submitting) {
      return;
    }

    state = SubmissionStatus.submitting;

    try {
      final repository = ref.read(signupRepositoryProvider);
      final formData = ref.read(onboardingFormNotifierProvider);

      final success = await repository.submitOnboardingData(formData);

      if (success) {
        state = SubmissionStatus.success;
      } else {
        state = SubmissionStatus.error;
      }
    } catch (e) {
      debugPrint('Error submitting onboarding data: $e');
      state = SubmissionStatus.error;
    }
  }

  void resetSubmissionStatus() {
    state = SubmissionStatus.initial;
  }
}

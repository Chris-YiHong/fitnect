import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupApiProvider = Provider<SignupApi>((ref) {
  return SignupApi();
});

class SignupApi {
  /// Submit user onboarding data to the backend
  Future<bool> submitOnboardingData(OnboardingFormModel formData) async {
    // In a real app, this would send data to a backend service
    // For now, we'll just simulate a network delay and success
    await Future.delayed(const Duration(seconds: 1));

    // Simulate API call here
    print('Submitting onboarding data: ${formData.toString()}');

    // Always return success for demo
    return true;
  }
}

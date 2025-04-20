import 'package:fitnect/modules/signup/api/signup_api.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupRepositoryProvider = Provider<SignupRepository>((ref) {
  return SignupRepository(signupApi: ref.read(signupApiProvider));
});

class SignupRepository {
  final SignupApi _signupApi;

  SignupRepository({required SignupApi signupApi}) : _signupApi = signupApi;

  /// Submit the onboarding data from the form
  Future<bool> submitOnboardingData(OnboardingFormModel data) async {
    try {
      return await _signupApi.submitOnboardingData(data);
    } catch (error) {
      // Log error or handle differently in a real app
      print('Error in signup repository: $error');
      rethrow;
    }
  }
}

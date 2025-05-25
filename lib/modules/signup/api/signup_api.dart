import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/signup/domain/model/onboarding_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final signupApiProvider = Provider<SignupApi>((ref) {
  return SignupApi(client: ref.read(httpClientProvider));
});

class SignupApi {
  static const String _onboardingEndpoint = '/users/onboarding';
  final HttpClient _client;

  SignupApi({required HttpClient client}) : _client = client;

  /// Submit user onboarding data to the backend
  Future<bool> submitOnboardingData(OnboardingFormModel formData) async {
    try {
      final response = await _client.post(
        _onboardingEndpoint,
        data: formData.toJson(),
      );
      print('Response data: ${response.data}');
      print('Response type: ${response.data.runtimeType}');
      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          return data['code'] == 200;
        } else if (response.data is String) {
          // Try to decode if it's a JSON string
          try {
            final decoded = jsonDecode(response.data as String);
            if (decoded is Map<String, dynamic>) {
              return decoded['code'] == 200;
            }
          } catch (_) {
            // Not JSON, handle as plain string if needed
            return false;
          }
        }
      }
      return false;
    } on DioException catch (e) {
      // Optionally log or handle error
      return false;
    }
  }
}

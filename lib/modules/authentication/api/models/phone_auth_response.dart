import 'package:json_annotation/json_annotation.dart';

/// Response model for the Phone authentication API
class PhoneAuthResponse {
  /// Status message from the server
  final String message;

  /// Authentication token to be used for API calls
  final String token;

  /// Whether the user has completed onboarding
  final bool onBoarding;

  /// Response status code
  final int code;

  /// Constructor for the Phone auth response
  const PhoneAuthResponse({
    required this.message,
    required this.token,
    required this.onBoarding,
    required this.code,
  });

  /// Factory constructor to create a PhoneAuthResponse from JSON
  factory PhoneAuthResponse.fromJson(Map<String, dynamic> json) {
    return PhoneAuthResponse(
      message: json['msg'] as String? ?? '',
      token: json['token'] as String? ?? '',
      onBoarding: json['onBoarding'] as bool? ?? false,
      code: json['code'] as int? ?? 0,
    );
  }

  /// Converts PhoneAuthResponse instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'msg': message,
      'token': token,
      'onBoarding': onBoarding,
      'code': code,
    };
  }

  @override
  String toString() =>
      'PhoneAuthResponse(message: $message, token: $token, onBoarding: $onBoarding, code: $code)';
}

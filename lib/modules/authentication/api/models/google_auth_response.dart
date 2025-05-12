import 'package:json_annotation/json_annotation.dart';

/// Response model for the Google authentication API
class GoogleAuthResponse {
  /// Status message from the server
  final String message;

  /// Authentication token to be used for API calls
  final String token;

  /// Whether the user has completed onboarding
  final bool onBoarding;

  /// Response status code
  final int code;

  /// Constructor for the Google auth response
  const GoogleAuthResponse({
    required this.message,
    required this.token,
    required this.onBoarding,
    required this.code,
  });

  /// Factory constructor to create a GoogleAuthResponse from JSON
  factory GoogleAuthResponse.fromJson(Map<String, dynamic> json) {
    return GoogleAuthResponse(
      message: json['msg'] as String? ?? '',
      token: json['token'] as String? ?? '',
      onBoarding: json['onBoarding'] as bool? ?? false,
      code: json['code'] as int? ?? 0,
    );
  }

  /// Converts GoogleAuthResponse instance to a JSON map
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
      'GoogleAuthResponse(message: $message, token: $token, onBoarding: $onBoarding, code: $code)';
}

import 'package:json_annotation/json_annotation.dart';

/// Request model for the Google authentication API
class GoogleAuthRequest {
  /// Google ID of the user
  final String googleId;

  /// Email of the user
  final String email;

  /// Constructor for the Google auth request
  const GoogleAuthRequest({required this.googleId, required this.email});

  /// Factory constructor to create a GoogleAuthRequest from JSON
  factory GoogleAuthRequest.fromJson(Map<String, dynamic> json) {
    return GoogleAuthRequest(
      googleId: json['googleId'] as String,
      email: json['email'] as String,
    );
  }

  /// Converts GoogleAuthRequest instance to a JSON map
  Map<String, dynamic> toJson() {
    return {'googleId': googleId, 'email': email};
  }

  @override
  String toString() => 'GoogleAuthRequest(googleId: $googleId, email: $email)';
}

import 'package:json_annotation/json_annotation.dart';

/// Request model for the Phone authentication API
class PhoneAuthRequest {
  /// Phone number of the user
  final String phoneNumber;

  /// Optional Google ID for linking phone to a Google account
  final String? googleId;

  /// Constructor for the Phone auth request
  const PhoneAuthRequest({required this.phoneNumber, this.googleId});

  /// Factory constructor to create a PhoneAuthRequest from JSON
  factory PhoneAuthRequest.fromJson(Map<String, dynamic> json) {
    return PhoneAuthRequest(
      phoneNumber: json['phoneNumber'] as String,
      googleId: json['googleId'] as String?,
    );
  }

  /// Converts PhoneAuthRequest instance to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'phoneNumber': phoneNumber};

    if (googleId != null) {
      data['googleId'] = googleId;
    }

    return data;
  }

  @override
  String toString() =>
      'PhoneAuthRequest(phoneNumber: $phoneNumber, googleId: $googleId)';
}

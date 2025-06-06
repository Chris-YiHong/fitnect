import 'package:fitnect/core/data/entities/auth_result.dart';
import 'package:fitnect/core/data/entities/user_entity.dart';
import 'package:fitnect/core/initializer/onstart_service.dart';

abstract class AuthenticationApi implements OnStartService {
  /// Initialize the authentication API
  Future<void> init();

  /// Get the current user credentials or null if not connected
  Future<Credentials?> get();

  /// Signup a new user using [email] and [password]
  Future<Credentials> signup(String email, String password);

  /// Signin an existing user using [email] and [password]
  /// If the user is not found, an [SigninException] is thrown
  Future<Credentials> signin(String email, String password);

  /// Signout the current user
  Future<void> signout();

  /// Signin anonymously
  Future<Credentials> signinAnonymously();

  /// Signin with Google account
  /// Requires the [google_sign_in](https://pub.dev/packages/google_sign_in) package
  Future<AuthResult> signinWithGoogle();

  /// Signin with Google Play account
  /// Requires the [google_sign_in](https://pub.dev/packages/google_sign_in) package
  Future<Credentials> signinWithGooglePlay();

  /// Signin with Facebook account
  /// Requires the [flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth) package
  Future<Credentials> signinWithFacebook();

  /// Signin with Apple account
  Future<Credentials> signinWithApple();

  /// Recover password if user signed up with email/password
  Future<void> recoverPassword(String email);

  /// Request a OTP code to be sent to the provided phone number
  /// Returns a verification ID that will be used to confirm the code
  Future<String> signinWithPhone(String phoneNumber);

  /// Verify the OTP code and authenticate the user
  /// [verificationId] is the ID returned by [requestPhoneAuth]
  /// [otp] is the code received by the user
  Future<AuthResult> verifyPhoneAuth(String verificationId, String otp);

  /// Update the phone number of the current user
  /// [phoneNumber] is the new phone number to set
  /// You need to call [confirmLinkPhoneAuth] to confirm the change
  Future<String> updateAuthPhone(String phoneNumber);

  /// Confirm the link of a phone number to the current user
  /// [verificationId] is the ID returned by [requestPhoneAuth]
  /// [otp] is the code received by the user
  Future<Credentials> confirmLinkPhoneAuth(String verificationId, String otp);
}

class PhoneAlreadyLinkedException implements Exception {
  PhoneAlreadyLinkedException();
}

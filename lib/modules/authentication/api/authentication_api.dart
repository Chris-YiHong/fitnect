import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/entities/auth_result.dart';
import 'package:fitnect/core/data/entities/user_entity.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/authentication/api/authentication_api_interface.dart';
import 'package:fitnect/modules/authentication/api/models/google_auth_request.dart';
import 'package:fitnect/modules/authentication/api/models/google_auth_response.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:logger/logger.dart';

import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';

final authenticationApiProvider = Provider<AuthenticationApi>(
  (ref) => HttpAuthenticationApi(
    logger: Logger(),
    client: ref.read(httpClientProvider),
  ),
);

class HttpAuthenticationApi implements AuthenticationApi {
  final Logger _logger;
  final HttpClient _client;

  HttpAuthenticationApi({required Logger logger, required HttpClient client})
    : _logger = logger,
      _client = client;

  @override
  Future<void> init() async {}

  @override
  Future<Credentials> signup(String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/signup',
        data: {'email': email, 'password': password},
      );
      return Credentials.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }

  @override
  Future<Credentials> signin(String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/signin',
        data: {'email': email, 'password': password},
      );
      return Credentials.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      _logger.e(e);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }

  @override
  Future<void> recoverPassword(String email) async {
    try {
      await _client.post('/auth/recover-password', data: {'email': email});
    } on DioException catch (e) {
      _logger.e(e);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }

  @override
  Future<Credentials> signinAnonymously() {
    throw UnimplementedError();
  }

  @override
  Future<void> signout() async {}

  @override
  Future<AuthResult> signinWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? loginResult = await googleSignIn.signIn();

      if (loginResult == null) {
        // User canceled the sign-in flow
        throw ApiError(
          code: 401,
          message: 'Google sign-in was canceled by the user',
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await loginResult.authentication;

      _logger.d('Google sign-in successful: ${loginResult.email}');

      try {
        // Development fallback for when there's no backend
        if (kDebugMode && false) {
          // Set to true to use development fallback for testing
          _logger.w('Using development mode authentication - no backend calls');
          // Return fake credentials for development
          return AuthResult(
            credentials: Credentials(
              id: loginResult.id,
              token: 'fake-token-${DateTime.now().millisecondsSinceEpoch}',
            ),
            isNewUser: false, // Set to true to test onboarding flow
            userEntity: UserEntity(
              id: loginResult.id,
              email: loginResult.email,
              name: loginResult.displayName,
              avatarPath: loginResult.photoUrl,
              creationDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              onboarded: false, // Set to false to test onboarding flow
            ),
          );
        }

        // Create the request payload
        final googleAuthRequest = GoogleAuthRequest(
          googleId: loginResult.id,
          email: loginResult.email,
        );

        _logger.d(
          'Sending Google auth request: ${googleAuthRequest.toString()}',
        );

        // Send the request to the Google auth endpoint
        final response = await _client.post(
          '/users/google_auth',
          data: googleAuthRequest.toJson(),
        );

        _logger.d('Google auth response received: ${response.data}');

        // Parse the response
        final googleAuthResponse = GoogleAuthResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        _logger.d(
          'Parsed Google auth response: ${googleAuthResponse.toString()}',
        );
        _logger.d(
          'onBoarding value from response: ${googleAuthResponse.onBoarding}',
        );

        // Check if the response was successful
        if (googleAuthResponse.code != 200) {
          throw ApiError(
            code: googleAuthResponse.code,
            message: googleAuthResponse.message,
          );
        }

        // Create the credentials with the token from the response
        final credentials = Credentials(
          id: loginResult.id, // Use Google ID as the user ID
          token: googleAuthResponse.token,
        );

        // For clarity: if onBoarding is true, the user has already onboarded
        // and is therefore NOT a new user
        final isNewUser = !googleAuthResponse.onBoarding;
        _logger.d(
          'isNewUser determined as: $isNewUser (opposite of onBoarding)',
        );

        // Return the auth result
        return AuthResult(
          credentials: credentials,
          isNewUser: isNewUser,
          userEntity: UserEntity(
            id: loginResult.id,
            email: loginResult.email,
            name: loginResult.displayName,
            avatarPath: loginResult.photoUrl,
            creationDate: DateTime.now(),
            lastUpdateDate: DateTime.now(),
            onboarded: googleAuthResponse.onBoarding,
          ),
        );
      } on DioException catch (e) {
        // Handle backend-specific errors
        _logger.e('Backend authentication error: ${e.message}');

        // Fallback for development when server is unreachable
        if (kDebugMode &&
            (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.connectionError ||
                e.response?.statusCode == 404)) {
          _logger.w('Backend unreachable, using development fallback');
          return AuthResult(
            credentials: Credentials(
              id: loginResult.id,
              token: 'fake-token-${DateTime.now().millisecondsSinceEpoch}',
            ),
            isNewUser: true, // Change to test different flows
            userEntity: UserEntity(
              id: loginResult.id,
              email: loginResult.email,
              name: loginResult.displayName,
              avatarPath: loginResult.photoUrl,
              creationDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              onboarded: false, // User hasn't completed onboarding
            ),
          );
        }

        throw ApiError.fromDioException(e);
      }
    } on PlatformException catch (e) {
      _logger.e('Google sign-in platform error: ${e.code} - ${e.message}');

      // Handle specific error codes
      if (e.code == 'sign_in_failed' && e.message?.contains('10:') == true) {
        throw ApiError(
          code: 400,
          message:
              'Google Sign-In configuration error. Please ensure your Google Services files are correctly set up.',
        );
      }

      throw ApiError(code: 400, message: 'Google Sign-In failed: ${e.message}');
    } catch (e) {
      _logger.e('Google sign-in error: $e');
      throw ApiError(
        code: 500,
        message: 'Failed to authenticate with Google: $e',
      );
    }
  }

  @override
  Future<Credentials> signinWithGooglePlay() async {
    throw UnimplementedError('''
    ❌ call the command 'dart run cli/bin/apparence_cli.dart auth --provider=googlePlay'
    then edit lib/modules/authentication/api/authentication_api.dart
    - See docs/social_auth.md for more details
    ''');
  }

  @override
  Future<Credentials> signinWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
        // add any other requested scopes
      ],
    );
    throw UnimplementedError('''
    ❌ You must edit lib/modules/authentication/api/authentication_api.dart 
    to send the Oauth2 token result to your backend
    ----------------
    Please follow the instructions here:
    https://pub.dev/packages/sign_in_with_apple
    ''');
  }

  @override
  Future<Credentials> signinWithFacebook() {
    throw UnimplementedError('''
    ❌ call the command 'dart run cli/bin/apparence_cli.dart auth --provider=facebook'
    then edit lib/modules/authentication/api/authentication_api.dart
    - See docs/social_auth.md for more details
    ''');
  }

  @override
  Future<Credentials?> get() {
    // don't implement this method for REST api mode
    // This is only for Firebase or Supabase mode
    throw UnimplementedError();
  }

  @override
  Future<String> signinWithPhone(String phoneNumber) {
    throw UnimplementedError();
  }

  @override
  Future<Credentials> verifyPhoneAuth(String verificationId, String otp) {
    throw UnimplementedError();
  }

  @override
  Future<String> updateAuthPhone(String phoneNumber) {
    throw UnimplementedError();
  }

  @override
  Future<Credentials> confirmLinkPhoneAuth(String verificationId, String otp) {
    throw UnimplementedError();
  }
}

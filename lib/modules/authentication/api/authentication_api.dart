import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/entities/auth_result.dart';
import 'package:fitnect/core/data/entities/user_entity.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/authentication/api/authentication_api_interface.dart';

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

      // Get the ID token to send to your backend
      final idToken = googleAuth.idToken;
      if (idToken == null) {
        throw ApiError(code: 400, message: 'Failed to obtain Google ID token');
      }

      try {
        // Development fallback for when there's no backend
        if (kDebugMode && false) {
          // Change to true to use fake auth during development
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

        // Send the ID token to your backend for verification and authentication
        final response = await _client.post(
          '/auth/google',
          data: {
            'idToken': idToken,
            'email': loginResult.email,
            'name': loginResult.displayName,
            'photoUrl': loginResult.photoUrl,
          },
        );

        // Parse the response from your backend
        final data = response.data as Map<String, dynamic>;

        final credentials = Credentials(
          id: data['id'] as String,
          token: data['token'] as String,
        );

        // Check if this is a new user
        final isNewUser = data['isNewUser'] as bool;

        // Parse user entity if included in response
        UserEntity? userEntity;
        if (data.containsKey('user')) {
          userEntity = UserEntity.fromJson(
            data['user'] as Map<String, dynamic>,
          );
        }

        return AuthResult(
          credentials: credentials,
          isNewUser: isNewUser,
          userEntity: userEntity,
        );
      } on DioException catch (e) {
        // Handle backend-specific errors
        _logger.e('Backend authentication error: ${e.message}');

        // Fallback for development when server is unreachable
        if (kDebugMode &&
            (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.connectionError)) {
          _logger.w('Backend unreachable, using development fallback');
          return AuthResult(
            credentials: Credentials(
              id: loginResult.id,
              token: 'fake-token-${DateTime.now().millisecondsSinceEpoch}',
            ),
            isNewUser: true, // Change to test different flows
            userEntity: null,
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

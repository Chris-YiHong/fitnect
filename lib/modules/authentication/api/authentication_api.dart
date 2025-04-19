import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/entities/user_entity.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/authentication/api/authentication_api_interface.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:logger/logger.dart';

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
  Future<Credentials> signinWithGoogle() async {
    final loginResult =
        await GoogleSignIn(
          clientId: const String.fromEnvironment('GOOGLE_CLIENT_ID'),
        ).signIn();
    final googleAuth = await loginResult?.authentication;
    throw UnimplementedError('''
    ❌ You must edit lib/modules/authentication/api/authentication_api.dart 
    to send the Oauth2 token result to your backend
    ''');
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

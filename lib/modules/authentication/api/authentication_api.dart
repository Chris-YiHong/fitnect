import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/entities/auth_result.dart';
import 'package:fitnect/core/data/entities/user_entity.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/authentication/api/authentication_api_interface.dart';
import 'package:fitnect/modules/authentication/api/models/google_auth_request.dart';
import 'package:fitnect/modules/authentication/api/models/google_auth_response.dart';
import 'package:fitnect/modules/authentication/api/models/phone_auth_request.dart';
import 'package:fitnect/modules/authentication/api/models/phone_auth_response.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:logger/logger.dart';

import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

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
  Future<String> signinWithPhone(String phoneNumber) async {
    try {
      _logger.d("Starting phone authentication for $phoneNumber");

      final completer = Completer<String>();

      // Sign out first to prevent auto sign-in
      try {
        await FirebaseAuth.instance.signOut();
        _logger.d("Signed out to prevent auto-authentication");
      } catch (e) {
        _logger.w("Error signing out before phone auth: $e");
      }

      try {
        // Prevent errors like "reCAPTCHA verification already pending"
        await Future.delayed(const Duration(milliseconds: 500));

        // Set up verification callbacks
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(
            seconds: 120,
          ), // Increase timeout for better experience
          verificationCompleted: (PhoneAuthCredential credential) async {
            _logger.d(
              "Auto-verification completed, but we will not use it to ensure OTP screen is shown",
            );
            // We do not auto-complete to ensure the OTP screen is shown
          },
          verificationFailed: (FirebaseAuthException e) {
            _logger.e(
              "Phone verification failed: ${e.message ?? 'Unknown error'}",
            );
            if (!completer.isCompleted) {
              completer.completeError(
                ApiError(
                  code: 400,
                  message: e.message ?? 'Phone verification failed',
                ),
              );
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            _logger.d(
              "Verification code sent to $phoneNumber with ID: $verificationId",
            );
            if (!completer.isCompleted) {
              completer.complete(verificationId);
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            _logger.w(
              "Auto retrieval timeout for verification ID: $verificationId",
            );
            if (!completer.isCompleted && verificationId.isNotEmpty) {
              completer.complete(verificationId);
            } else if (!completer.isCompleted) {
              completer.completeError(
                ApiError(
                  code: 408,
                  message:
                      'Code auto retrieval timeout without valid verification ID',
                ),
              );
            }
          },
          // Disable auto-retrieval to force manual OTP entry
          forceResendingToken: null,
        );

        // Wait for verification ID with timeout
        final verificationId = await completer.future.timeout(
          const Duration(seconds: 60),
          onTimeout: () {
            _logger.e("Timeout waiting for verification ID");
            throw ApiError(
              code: 408,
              message: "Timeout waiting for verification ID",
            );
          },
        );

        // Return verification ID
        _logger.d("Successfully got verification ID: $verificationId");
        return verificationId;
      } catch (e) {
        if (e is ApiError) rethrow;
        _logger.e("Error during phone authentication: $e");
        throw ApiError(
          code: 500,
          message: "Failed to start phone verification: $e",
        );
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      _logger.e("Unexpected error in phone auth: $e");
      throw ApiError(code: 500, message: "Unexpected error: $e");
    }
  }

  @override
  Future<AuthResult> verifyPhoneAuth(
    String verificationId,
    String smsCode,
  ) async {
    try {
      _logger.d("Verifying SMS code");

      // Create the credential
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Sign in with credential
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      if (userCredential.user == null) {
        throw ApiError(
          code: 401,
          message: 'Failed to authenticate with Firebase',
        );
      }

      _logger.d(
        'Firebase phone auth successful for ${userCredential.user!.phoneNumber}',
      );

      // Get the Firebase ID token
      final String? idTokenNullable = await userCredential.user!.getIdToken();
      if (idTokenNullable == null) {
        throw ApiError(code: 500, message: 'Failed to get Firebase ID token');
      }
      final String idToken = idTokenNullable;
      _logger.d('Got Firebase ID token for phone auth');

      // // Development fallback for when there's no backend
      // if (kDebugMode) {
      //   _logger.w(
      //     'Using development mode authentication for phone - bypassing backend call',
      //   );
      //   // Return fake auth result for development
      //   return AuthResult(
      //     credentials: Credentials(
      //       id: userCredential.user!.uid,
      //       token: 'fake-phone-token-${DateTime.now().millisecondsSinceEpoch}',
      //     ),
      //     isNewUser: true, // Change to test different flows
      //     userEntity: UserEntity(
      //       id: userCredential.user!.uid,
      //       email: userCredential.user!.email,
      //       name: userCredential.user!.displayName,
      //       avatarPath: userCredential.user!.photoURL,
      //       creationDate: DateTime.now(),
      //       lastUpdateDate: DateTime.now(),
      //       onboarded: false, // User hasn't completed onboarding
      //     ),
      //   );
      // }

      // Create the request payload with idToken for our backend
      final requestData = {'idToken': idToken};

      _logger.d('Sending Phone auth request to backend with idToken');

      // Send the request to the Phone auth endpoint
      final response = await _client.post(
        '/users/phone_auth',
        data: requestData,
      );

      _logger.d('Phone auth response received: ${response.data}');

      // Parse the response
      final phoneAuthResponse = PhoneAuthResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      _logger.d('Parsed Phone auth response: ${phoneAuthResponse.toString()}');

      // Check if the response was successful
      if (phoneAuthResponse.code != 200) {
        throw ApiError(
          code: phoneAuthResponse.code,
          message: phoneAuthResponse.message,
        );
      }

      // Create the credentials with the token from the response
      final credentials = Credentials(
        id: userCredential.user!.uid,
        token: phoneAuthResponse.token,
      );

      // For clarity: if onBoarding is true, the user has already onboarded
      // and is therefore NOT a new user
      final isNewUser = !phoneAuthResponse.onBoarding;
      _logger.d('isNewUser determined as: $isNewUser (opposite of onBoarding)');

      // Return the auth result
      return AuthResult(
        credentials: credentials,
        isNewUser: isNewUser,
        userEntity: UserEntity(
          id: userCredential.user!.uid,
          email: userCredential.user!.email,
          name: userCredential.user!.displayName,
          avatarPath: userCredential.user!.photoURL,
          creationDate: DateTime.now(),
          lastUpdateDate: DateTime.now(),
          onboarded: phoneAuthResponse.onBoarding,
        ),
      );
    } on FirebaseAuthException catch (e) {
      _logger.e('Firebase verification failed: ${e.message}');
      throw ApiError(
        code: e.code == 'invalid-verification-code' ? 400 : 500,
        message: e.message ?? 'OTP verification failed',
      );
    } on DioException catch (e) {
      _logger.e('Backend verification failed: ${e.message}');
      // Fallback for development when server is unreachable
      if (kDebugMode &&
          (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.connectionError ||
              e.response?.statusCode == 404)) {
        _logger.w(
          'Backend unreachable for phone verification, using development fallback',
        );
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          return AuthResult(
            credentials: Credentials(
              id: user.uid,
              token:
                  'fake-phone-token-${DateTime.now().millisecondsSinceEpoch}',
            ),
            isNewUser: true, // Change to test different flows
            userEntity: UserEntity(
              id: user.uid,
              email: user.email,
              name: user.displayName,
              avatarPath: user.photoURL,
              creationDate: DateTime.now(),
              lastUpdateDate: DateTime.now(),
              onboarded: false, // User hasn't completed onboarding
            ),
          );
        }
      }
      throw ApiError.fromDioException(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      _logger.e('OTP verification error: $e');
      throw ApiError(code: 500, message: 'Failed to verify OTP: $e');
    }
  }

  @override
  Future<String> updateAuthPhone(String phoneNumber) async {
    try {
      _logger.d('Updating phone number to $phoneNumber');

      // Check if user is signed in with another method
      final FirebaseAuth auth = FirebaseAuth.instance;
      final currentUser = auth.currentUser;

      if (currentUser == null) {
        throw ApiError(code: 401, message: 'User not authenticated');
      }

      // If the user already has a phone number linked, throw an exception
      if (currentUser.phoneNumber != null) {
        throw PhoneAlreadyLinkedException();
      }

      String verificationId = '';

      // Start phone verification
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback is invoked in case of auto-verification (Android only)
          _logger.d('Auto-verification completed for phone linking');
        },
        verificationFailed: (FirebaseException e) {
          _logger.e('Phone linking verification failed: ${e.message}');
          throw ApiError(
            code: e.code == 'invalid-phone-number' ? 400 : 500,
            message: e.message ?? 'Phone verification failed',
          );
        },
        codeSent: (String vId, int? resendToken) {
          _logger.d('Verification code sent for phone linking to $phoneNumber');
          verificationId = vId;
        },
        codeAutoRetrievalTimeout: (String vId) {
          if (verificationId.isEmpty) {
            verificationId = vId;
          }
        },
        timeout: const Duration(seconds: 60),
      );

      // Wait for the verification ID to be set
      int attempts = 0;
      while (verificationId.isEmpty && attempts < 50) {
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }

      if (verificationId.isEmpty) {
        throw ApiError(
          code: 500,
          message: 'Failed to get verification ID for phone linking',
        );
      }

      return verificationId;
    } on FirebaseException catch (e) {
      _logger.e('Firebase phone linking error: ${e.message}');
      throw ApiError(
        code: e.code == 'invalid-phone-number' ? 400 : 500,
        message: e.message ?? 'Phone linking failed',
      );
    } catch (e) {
      if (e is ApiError || e is PhoneAlreadyLinkedException) {
        rethrow;
      }
      _logger.e('Phone linking error: $e');
      throw ApiError(code: 500, message: 'Failed to link phone: $e');
    }
  }

  @override
  Future<Credentials> confirmLinkPhoneAuth(
    String verificationId,
    String otp,
  ) async {
    try {
      _logger.d('Confirming phone number linking with OTP');

      // Initialize Firebase Auth
      final FirebaseAuth auth = FirebaseAuth.instance;
      final currentUser = auth.currentUser;

      if (currentUser == null) {
        throw ApiError(code: 401, message: 'User not authenticated');
      }

      // Create the credential
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Link phone number to current user
      final userCredential = await currentUser.linkWithCredential(credential);

      final String? phoneNumber = userCredential.user?.phoneNumber;

      if (phoneNumber == null) {
        throw ApiError(
          code: 500,
          message: 'Phone number not available after linking',
        );
      }

      _logger.d('Phone linked successfully: $phoneNumber');

      // Get Google ID if user is signed in with Google
      String? googleId;
      for (final providerProfile in currentUser.providerData) {
        if (providerProfile.providerId == 'google.com') {
          googleId = providerProfile.uid;
          break;
        }
      }

      // Create the request payload for our backend
      final phoneAuthRequest = PhoneAuthRequest(
        phoneNumber: phoneNumber,
        googleId: googleId,
      );

      _logger.d(
        'Sending Phone link request to backend: ${phoneAuthRequest.toString()}',
      );

      // Send the request to the Phone auth endpoint
      final response = await _client.post(
        '/users/phone_auth',
        data: phoneAuthRequest.toJson(),
      );

      _logger.d('Phone link response received: ${response.data}');

      // Parse the response
      final phoneAuthResponse = PhoneAuthResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      _logger.d('Parsed Phone link response: ${phoneAuthResponse.toString()}');

      // Check if the response was successful
      if (phoneAuthResponse.code != 200) {
        throw ApiError(
          code: phoneAuthResponse.code,
          message: phoneAuthResponse.message,
        );
      }

      // Create the credentials with the token from the response
      final credentials = Credentials(
        id: currentUser.uid,
        token: phoneAuthResponse.token,
      );

      return credentials;
    } on FirebaseAuthException catch (e) {
      _logger.e('Firebase link verification failed: ${e.message}');

      if (e.code == 'credential-already-in-use') {
        throw PhoneAlreadyLinkedException();
      }

      throw ApiError(
        code: e.code == 'invalid-verification-code' ? 400 : 500,
        message: e.message ?? 'OTP verification failed',
      );
    } on DioException catch (e) {
      _logger.e('Backend link verification failed: ${e.message}');
      throw ApiError.fromDioException(e);
    } catch (e) {
      if (e is ApiError || e is PhoneAlreadyLinkedException) {
        rethrow;
      }
      _logger.e('Phone link verification error: $e');
      throw ApiError(code: 500, message: 'Failed to verify phone link: $e');
    }
  }
}

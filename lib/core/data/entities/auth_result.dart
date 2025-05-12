import 'package:fitnect/core/data/entities/user_entity.dart';

/// Result of authentication operations containing credentials and whether the user is new
class AuthResult {
  /// The user's credentials (id and token)
  final Credentials credentials;

  /// Whether this is a new user that just signed up (true) or an existing user (false)
  final bool isNewUser;

  /// Optional user entity data that might be returned with authentication
  final UserEntity? userEntity;

  const AuthResult({
    required this.credentials,
    required this.isNewUser,
    this.userEntity,
  });
}

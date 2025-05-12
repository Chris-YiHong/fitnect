import 'dart:typed_data';

import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/core/data/entities/upload_result.dart';
import 'package:fitnect/core/data/entities/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final userApiProvider = Provider<UserApi>(
  (ref) => UserApi(client: ref.read(httpClientProvider), logger: Logger()),
);

class UserApi {
  final HttpClient _client;
  final Logger _logger;

  UserApi({required HttpClient client, Logger? logger})
    : _client = client,
      _logger = logger ?? Logger();

  Future<UserEntity?> get(String id) async {
    try {
      // In development or testing, uncomment this section to use fake data if needed
      if (kDebugMode && false) {
        // Change to true to use fake data
        return _getFakeUser(id);
      }

      final response = await _client.get('/users/$id');
      if (response.data == null) {
        return null;
      }
      return UserEntity.fromJson(response.data! as Map<String, dynamic>);
    } on DioException catch (e) {
      // For 404 errors in debug mode, return a fake user for easier development
      if (kDebugMode && e.response?.statusCode == 404) {
        _logger.w(
          'User not found in backend, returning fake user for development',
        );
        return _getFakeUser(id);
      }
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      _logger.e('Error fetching user: $e', stackTrace: stacktrace);
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  /// Creates a fake user for development and testing
  UserEntity _getFakeUser(String id) {
    return UserEntity(
      id: id,
      email: 'user_$id@example.com',
      name: 'Test User',
      creationDate: DateTime.now(),
      lastUpdateDate: DateTime.now(),
      onboarded: false, // New users need onboarding
    );
  }

  Future<void> update(UserEntity user) async {
    try {
      final _ = await _client.put('/users/${user.id}', data: user.toJson());
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  Future<void> delete(String userId) async {
    try {
      final _ = await _client.delete('/users/$userId');
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  Future<void> deleteMe() async {
    try {
      final _ = await _client.delete('/users/me');
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  Future<void> create(UserEntity user) async {
    try {
      final _ = await _client.post('/users/${user.id}', data: user.toJson());
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  Stream<UploadResult> updateAvatar(String userId, Uint8List data) async* {
    throw UnimplementedError();
  }
}

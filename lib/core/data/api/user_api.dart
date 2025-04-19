import 'dart:typed_data';

import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/core/data/entities/upload_result.dart';
import 'package:fitnect/core/data/entities/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiProvider = Provider<UserApi>(
  (ref) => UserApi(client: ref.read(httpClientProvider)),
);

class UserApi {
  final HttpClient _client;

  UserApi({required HttpClient client}) : _client = client;

  Future<UserEntity?> get(String id) async {
    try {
      final response = await _client.get('/users/$id');
      if (response.data == null) {
        return null;
      }
      return UserEntity.fromJson(response.data! as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
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

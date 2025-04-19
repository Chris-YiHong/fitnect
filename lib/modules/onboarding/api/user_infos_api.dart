import 'dart:convert';

import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/modules/onboarding/api/entities/user_info_entity.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final userInfosApiProvider = Provider(
  (ref) => UserInfosApi(client: ref.read(httpClientProvider)),
);

class UserInfosApi {
  final HttpClient _client;
  final Logger _logger = Logger();

  UserInfosApi({required HttpClient client}) : _client = client;

  Future<List<UserInfoEntity>> getAll(String userId) async {
    try {
      final response = await _client.get('/users/$userId/infos');
      // final json = jsonDecode(response.data) as Map<String, dynamic>;
      if (response.data == null) {
        return [];
      }
      final data = response.data! as List<dynamic>;
      return data
          .map((e) => UserInfoEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e, stackTrace) {
      _logger.e(
        "Error while getting user subscription from backend: $e",
        stackTrace: stackTrace,
      );
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }

  Future<UserInfoEntity?> getByKey(String userId, String key) async {
    try {
      final response = await _client.get(
        '/users/$userId/infos',
        queryParameters: {'key': key},
      );
      return UserInfoEntity.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      _logger.e(
        "Error while getting user subscription from backend: $e",
        stackTrace: stackTrace,
      );
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }

  Future<void> create(String userId, UserInfoEntity info) async {
    try {
      await _client.post('/users/$userId/infos', data: info.toJson());
    } on DioException catch (e, stackTrace) {
      _logger.e(
        "Error while getting user subscription from backend: $e",
        stackTrace: stackTrace,
      );
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }

  Future<void> update(String userId, UserInfoEntity info) async {
    try {
      await _client.put('/users/$userId/infos/${info.id}', data: info.toJson());
    } on DioException catch (e, stackTrace) {
      _logger.e(
        "Error while getting user subscription from backend: $e",
        stackTrace: stackTrace,
      );
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }
}

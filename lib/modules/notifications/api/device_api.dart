import 'dart:async';

import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/notifications/api/entities/device_entity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart';

abstract class DeviceApi {
  /// We use a unique id for the device / installation
  /// This allows to send notifications to a specific device
  /// iOS and Android tends now to restrict the use of device id
  /// You could also generate your own id and store it in the device
  /// But as we use firebase for notifications we can use the firebase installation id
  Future<DeviceEntity> get();

  /// Register the device in the backend
  /// Of course your backend should check if the device is already registered
  /// throws an [ApiError] if something goes wrong
  Future<DeviceEntity> register(String userId, DeviceEntity device);

  /// Update the device in the backend
  /// throws an [ApiError] if something goes wrong
  Future<DeviceEntity> update(DeviceEntity device);

  /// Unregister the device in the backend
  Future<void> unregister(String userId, String deviceId);

  /// Listen to token refresh
  void onTokenRefresh(OnTokenRefresh onTokenRefresh);

  /// Remove the token refresh listener
  void removeOnTokenRefreshListener();
}

typedef OnTokenRefresh = void Function(String token);

final deviceApiProvider = Provider<DeviceApi>(
  (ref) => FirebaseDeviceApi(
    client: ref.read(httpClientProvider),
    messaging: FirebaseMessaging.instance,
    installations: FirebaseInstallations.instance,
  ),
);

class FirebaseDeviceApi implements DeviceApi {
  final Dio _client;
  final FirebaseMessaging _messaging;
  final FirebaseInstallations _installations;
  StreamSubscription? _onTokenRefreshSubscription;

  FirebaseDeviceApi({
    required Dio client,
    required FirebaseMessaging messaging,
    required FirebaseInstallations installations,
  }) : _client = client,
       _messaging = messaging,
       _installations = installations;

  @override
  Future<DeviceEntity> get() async {
    try {
      final installationId = await _installations.getId();
      final token = await _messaging.getToken();
      final os =
          Platform.isAndroid
              ? OperatingSystem
                  .android //
              : OperatingSystem.ios;
      return DeviceEntity(
        installationId: installationId,
        token: token!,
        operatingSystem: os,
        creationDate: DateTime.now(),
        lastUpdateDate: DateTime.now(),
      );
    } catch (e) {
      throw ApiError(code: 0, message: '$e');
    }
  }

  @override
  Future<DeviceEntity> register(String userId, DeviceEntity device) async {
    try {
      final response = await _client.post(
        '/users/$userId/devices',
        data: device.toJson(),
      );
      return DeviceEntity.fromJson(response.data! as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, trace) {
      throw ApiError(code: 0, message: '$e : $trace');
    }
  }

  @override
  Future<DeviceEntity> update(DeviceEntity device) async {
    try {
      final response = await _client.put(
        '/devices/${device.id}',
        data: device.toJson(),
      );
      return DeviceEntity.fromJson(response.data! as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, trace) {
      throw ApiError(code: 0, message: '$e: $trace');
    }
  }

  @override
  Future<void> unregister(String userId, String deviceId) async {
    try {
      await _client.delete('/devices/$deviceId');
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e) {
      throw ApiError(code: 0, message: '$e');
    }
  }

  @override
  void onTokenRefresh(OnTokenRefresh onTokenRefresh) {
    _onTokenRefreshSubscription = _messaging.onTokenRefresh.listen(
      (data) => onTokenRefresh(data),
    );
  }

  @override
  void removeOnTokenRefreshListener() {
    _onTokenRefreshSubscription?.cancel();
  }
}

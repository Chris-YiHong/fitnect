import 'dart:convert';

import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/notifications/api/entities/notifications_entity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

final notificationsApiProvider = Provider<NotificationsApi>(
  (ref) => FirebaseNotificationsApi(
    messaging: FirebaseMessaging.instance,
    logger: Logger(),
    client: ref.read(httpClientProvider),
  ),
);

/// This class is responsible for listening from firebase notifications
/// As I like repositories to not depend on external libraries
/// I wrapped some of the firebase messaging methods
///
/// You could use directly the firebase messaging methods but making a fake implementation
/// of this class would be harder.
abstract class NotificationsApi {
  /// Request permission to receive notifications
  Future<void> requestPermission();

  // Used to listen to notifications when the app is in foreground
  void setForegroundHandler(OnRemoteMessage handler);

  // Used to listen to notifications when the app is in background
  void setBackgroundHandler(OnRemoteMessage handler);

  // Used to listen to notifications when user clicks on the notification
  void setOnOpenNotificationHandler(OnRemoteMessage handler);

  // Used to get the past notifications from the server
  Future<List<NotificationEntity>> get(
    String userId, {
    DateTime? startDate,
    required int limit,
    int page = 0,
  });

  // Used to mark a notification as read
  Future<void> read(String userId, String notificationId);

  // Used to get the unread notifications count
  Stream<int> unreadNotifications(String userId);

  // Used to register to a topic
  void registerTopic(String topic);

  // Used to unregister from a topic
  void unregisterTopic(String topic);

  // Used to get the permission status
  Future<PermissionStatus> getPermissionStatus();
}

typedef OnRemoteMessage = Future<void> Function(RemoteMessage message);

class FirebaseNotificationsApi implements NotificationsApi {
  final FirebaseMessaging _messaging;
  final HttpClient _client;
  final Logger _logger;

  FirebaseNotificationsApi({
    required FirebaseMessaging messaging,
    required HttpClient client,
    required Logger logger,
  }) : _messaging = messaging,
       _client = client,
       _logger = logger;

  @override
  Future<void> requestPermission() async {
    try {
      await _messaging.requestPermission();
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  void setForegroundHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  @override
  void setBackgroundHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  @override
  void setOnOpenNotificationHandler(OnRemoteMessage handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  @override
  void registerTopic(String topic) {
    _messaging.subscribeToTopic(topic);
  }

  @override
  void unregisterTopic(String topic) {
    _messaging.unsubscribeFromTopic(topic);
  }

  @override
  Future<List<NotificationEntity>> get(
    String userId, {
    DateTime? startDate,
    required int limit,
    int page = 0,
  }) async {
    try {
      final response = await _client.get(
        '/users/$userId/notifications',
        queryParameters: {'page': page, 'pageSize': limit},
      );
      if (response.data == null) {
        return [];
      }
      final data = response.data! as List<dynamic>;
      return data
          .map((e) => NotificationEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  @override
  Future<void> read(String userId, String notificationId) async {
    try {
      final _ = await _client.put(
        '/users/$userId/notifications/$notificationId',
      );
    } on DioException catch (e) {
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  @override
  Stream<int> unreadNotifications(String userId) async* {
    try {
      final response = await _client.get<ResponseBody>(
        '/users/$userId/notifications/unread',
        options: Options(responseType: ResponseType.stream),
      );
      yield* utf8.decoder
          .bind(response.data!.stream)
          .map((line) => jsonDecode(line))
          .map((event) {
            final list = event as List<dynamic>;
            final lastItem = list.lastOrNull;
            if (list.isEmpty || lastItem == null) {
              return 0;
            }
            // ignore: avoid_dynamic_calls
            return lastItem['count'] as int; // this is for demo purposes
          });
    } on DioException catch (e, stacktrace) {
      debugPrint('$e: $stacktrace');
      throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
      debugPrint('$e: $stacktrace');
      throw ApiError(code: 0, message: '$e: $stacktrace');
    }
  }

  @override
  Future<PermissionStatus> getPermissionStatus() {
    return Permission.notification.status;
  }
}

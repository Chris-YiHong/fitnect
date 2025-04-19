import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_entity.freezed.dart';
part 'notifications_entity.g.dart';

enum NotificationTypes { WELCOME, OTHER, LINK }

@freezed
sealed class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    String? id,
    required String title,
    required DateTime creationDate,
    required String body,
    DateTime? readDate,
    NotificationTypes? type,
    Map<String, dynamic>? data,
  }) = NotificationData;

  factory NotificationEntity.fromJson(Map<String, Object?> json) =>
      _$NotificationEntityFromJson(json);
}

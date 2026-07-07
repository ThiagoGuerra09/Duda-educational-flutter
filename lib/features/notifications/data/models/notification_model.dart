import 'package:duda_educational_flutter/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.date,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        category: json['category'] as String,
        date: DateTime.parse(json['date'] as String),
        isRead: json['isRead'] as bool,
      );

  final String id;
  final String title;
  final String body;
  final String category;
  final DateTime date;
  final bool isRead;

  NotificationEntity toEntity() => NotificationEntity(
        id: id,
        title: title,
        body: body,
        category: category,
        date: date,
        isRead: isRead,
      );
}

class NotificationsResponseModel {
  NotificationsResponseModel({required this.notifications});

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationsResponseModel(
        notifications: (json['notifications'] as List<dynamic>)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final List<NotificationModel> notifications;
}

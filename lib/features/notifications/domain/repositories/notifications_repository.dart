import 'package:duda_educational_flutter/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsRepository {
  Future<List<NotificationEntity>> getNotifications();
}

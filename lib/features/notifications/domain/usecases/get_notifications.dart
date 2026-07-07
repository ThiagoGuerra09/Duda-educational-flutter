import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/notifications/domain/entities/notification_entity.dart';
import 'package:duda_educational_flutter/features/notifications/domain/repositories/notifications_repository.dart';

@injectable
class GetNotifications {
  const GetNotifications(this._repository);

  final NotificationsRepository _repository;

  Future<List<NotificationEntity>> call() => _repository.getNotifications();
}

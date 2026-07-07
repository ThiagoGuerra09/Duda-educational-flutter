import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/notifications/domain/entities/notification_entity.dart';

enum NotificationsStatus { initial, loading, success, failure }

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.selectedFilter = 'todas',
    this.errorMessage,
  });

  const NotificationsState.initial() : this();

  const NotificationsState.loading()
      : this(status: NotificationsStatus.loading);

  const NotificationsState.success(List<NotificationEntity> notifications)
      : this(status: NotificationsStatus.success, notifications: notifications);

  const NotificationsState.failure(String message)
      : this(status: NotificationsStatus.failure, errorMessage: message);

  final NotificationsStatus status;
  final List<NotificationEntity> notifications;
  final String selectedFilter;
  final String? errorMessage;

  List<NotificationEntity> get filteredNotifications {
    if (selectedFilter == 'todas') return notifications;
    return notifications
        .where((n) => n.category == selectedFilter)
        .toList();
  }

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationEntity>? notifications,
    String? selectedFilter,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, notifications, selectedFilter, errorMessage];
}

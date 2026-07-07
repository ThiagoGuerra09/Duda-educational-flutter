import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/notifications/domain/usecases/get_notifications.dart';
import 'package:duda_educational_flutter/features/notifications/presentation/cubit/notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._getNotifications)
      : super(const NotificationsState.initial());

  final GetNotifications _getNotifications;

  Future<void> loadNotifications() async {
    emit(const NotificationsState.loading());
    try {
      final notifications = await _getNotifications();
      emit(NotificationsState.success(notifications));
    } on ServerException catch (e) {
      emit(NotificationsState.failure(e.message));
    } on Failure catch (e) {
      emit(NotificationsState.failure(e.message));
    } catch (e) {
      emit(NotificationsState.failure(e.toString()));
    }
  }

  void setFilter(String filter) {
    emit(state.copyWith(selectedFilter: filter));
  }
}

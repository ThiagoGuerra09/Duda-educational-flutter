import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/features/notifications/data/models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}

@LazySingleton(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.notifications);
      final model = NotificationsResponseModel.fromJson(response.data!);
      return model.notifications;
    } on DioException {
      throw const ServerException('Erro ao carregar notificações');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/features/schedule/data/models/calendar_event_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<CalendarEventModel>> getCalendarEvents();
}

@LazySingleton(as: ScheduleRemoteDataSource)
class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  ScheduleRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<CalendarEventModel>> getCalendarEvents() async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.calendar);
      final model = CalendarResponseModel.fromJson(response.data!);
      return model.events;
    } on DioException {
      throw const ServerException('Erro ao carregar calendário');
    }
  }
}

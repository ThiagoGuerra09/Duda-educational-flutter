import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/cache/memory_cache.dart';
import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:duda_educational_flutter/features/schedule/domain/entities/calendar_event.dart';
import 'package:duda_educational_flutter/features/schedule/domain/repositories/schedule_repository.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(this._dataSource, this._cache);

  final ScheduleRemoteDataSource _dataSource;
  final MemoryCache _cache;

  static const _cacheKey = 'calendar_events';

  @override
  Future<List<CalendarEvent>> getCalendarEvents() async {
    final cached = _cache.get<List<CalendarEvent>>(_cacheKey);
    if (cached != null) return cached;

    final models = await _dataSource.getCalendarEvents();
    final entities = models.map((m) => m.toEntity()).toList();
    _cache.set(_cacheKey, entities, ttl: AppConstants.cacheTtl);
    return entities;
  }
}

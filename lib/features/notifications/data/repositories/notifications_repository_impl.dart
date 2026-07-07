import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/cache/memory_cache.dart';
import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:duda_educational_flutter/features/notifications/domain/entities/notification_entity.dart';
import 'package:duda_educational_flutter/features/notifications/domain/repositories/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._dataSource, this._cache);

  final NotificationsRemoteDataSource _dataSource;
  final MemoryCache _cache;

  static const _cacheKey = 'notifications';

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final cached = _cache.get<List<NotificationEntity>>(_cacheKey);
    if (cached != null) return cached;

    final models = await _dataSource.getNotifications();
    final entities = models.map((m) => m.toEntity()).toList();
    _cache.set(_cacheKey, entities, ttl: AppConstants.cacheTtl);
    return entities;
  }
}

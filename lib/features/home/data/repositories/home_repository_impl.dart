import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/cache/memory_cache.dart';
import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/features/home/data/datasources/home_remote_datasource.dart';
import 'package:duda_educational_flutter/features/home/domain/entities/home_data.dart';
import 'package:duda_educational_flutter/features/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._dataSource, this._cache);

  final HomeRemoteDataSource _dataSource;
  final MemoryCache _cache;

  static const _cacheKey = 'home_data';

  @override
  Future<HomeData> getHomeData() async {
    final cached = _cache.get<HomeData>(_cacheKey);
    if (cached != null) return cached;

    final model = await _dataSource.getHomeData();
    final entity = model.toEntity();
    _cache.set(_cacheKey, entity, ttl: AppConstants.cacheTtl);
    return entity;
  }
}

import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/cache/memory_cache.dart';
import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:duda_educational_flutter/features/profile/domain/entities/profile.dart';
import 'package:duda_educational_flutter/features/profile/domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource, this._cache);

  final ProfileRemoteDataSource _dataSource;
  final MemoryCache _cache;

  static const _cacheKey = 'profile';

  @override
  Future<Profile> getProfile() async {
    final cached = _cache.get<Profile>(_cacheKey);
    if (cached != null) return cached;

    final model = await _dataSource.getProfile();
    final entity = model.toEntity();
    _cache.set(_cacheKey, entity, ttl: AppConstants.cacheTtl);
    return entity;
  }
}

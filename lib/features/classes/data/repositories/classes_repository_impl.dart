import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/cache/memory_cache.dart';
import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/features/classes/data/datasources/classes_remote_datasource.dart';
import 'package:duda_educational_flutter/features/classes/domain/entities/class_detail.dart';
import 'package:duda_educational_flutter/features/classes/domain/entities/class_entity.dart';
import 'package:duda_educational_flutter/features/classes/domain/repositories/classes_repository.dart';

@LazySingleton(as: ClassesRepository)
class ClassesRepositoryImpl implements ClassesRepository {
  ClassesRepositoryImpl(this._dataSource, this._cache);

  final ClassesRemoteDataSource _dataSource;
  final MemoryCache _cache;

  static const _classesCacheKey = 'classes_list';

  @override
  Future<List<ClassEntity>> getClasses() async {
    final cached = _cache.get<List<ClassEntity>>(_classesCacheKey);
    if (cached != null) return cached;

    final models = await _dataSource.getClasses();
    final entities = models.map((m) => m.toEntity()).toList();
    _cache.set(_classesCacheKey, entities, ttl: AppConstants.cacheTtl);
    return entities;
  }

  @override
  Future<ClassDetail> getClassDetail(String id) async {
    final cacheKey = 'class_detail_$id';
    final cached = _cache.get<ClassDetail>(cacheKey);
    if (cached != null) return cached;

    final model = await _dataSource.getClassDetail(id);
    final entity = model.toEntity();
    _cache.set(cacheKey, entity, ttl: AppConstants.cacheTtl);
    return entity;
  }
}

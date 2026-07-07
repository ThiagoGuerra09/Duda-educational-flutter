import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/features/classes/data/models/class_detail_model.dart';
import 'package:duda_educational_flutter/features/classes/data/models/class_model.dart';

abstract class ClassesRemoteDataSource {
  Future<List<ClassModel>> getClasses();

  Future<ClassDetailModel> getClassDetail(String id);
}

@LazySingleton(as: ClassesRemoteDataSource)
class ClassesRemoteDataSourceImpl implements ClassesRemoteDataSource {
  ClassesRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ClassModel>> getClasses() async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.classes);
      final model = ClassesResponseModel.fromJson(response.data!);
      return model.classes;
    } on DioException {
      throw const ServerException('Erro ao carregar turmas');
    }
  }

  @override
  Future<ClassDetailModel> getClassDetail(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiEndpoints.classDetail}/$id',
      );
      return ClassDetailModel.fromJson(response.data!);
    } on DioException {
      throw const ServerException('Erro ao carregar detalhes da turma');
    }
  }
}

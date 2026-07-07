import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/features/home/data/models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeData();
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<HomeModel> getHomeData() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.home);
      return HomeModel.fromJson(response.data!);
    } on DioException {
      throw const ServerException('Erro ao carregar home');
    }
  }
}

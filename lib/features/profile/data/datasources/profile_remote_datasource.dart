import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.profile);
      return ProfileModel.fromJson(response.data!);
    } on DioException {
      throw const ServerException('Erro ao carregar perfil');
    }
  }
}

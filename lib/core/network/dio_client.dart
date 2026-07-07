import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/constants/app_constants.dart';
import 'package:duda_educational_flutter/core/network/mock_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(MockInterceptor());
    return dio;
  }
}

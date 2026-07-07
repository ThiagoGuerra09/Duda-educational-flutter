import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/durations.dart';

class MockInterceptor extends Interceptor {
  static const _routeAssets = {
    '/api/home': 'assets/mock/home.json',
    '/api/classes': 'assets/mock/classes.json',
    '/api/notifications': 'assets/mock/notifications.json',
    '/api/profile': 'assets/mock/profile.json',
    '/api/chat': 'assets/mock/chat.json',
    '/api/messages': 'assets/mock/messages.json',
    '/api/calendar': 'assets/mock/calendar.json',
  };

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Future<void>.delayed(AppDurations.networkDelay);

    if (options.queryParameters['fail'] == 'true') {
      return handler.reject(
        DioException(
          requestOptions: options,
          message: 'Simulated network error',
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: options,
            statusCode: 500,
          ),
        ),
      );
    }

    if (options.path.startsWith('/api/auth/login')) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {'token': 'mock-token', 'userId': 'prof-001'},
        ),
      );
    }

    final assetPath = _resolveAssetPath(options.path);
    if (assetPath == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          message: 'Route not found: ${options.path}',
          type: DioExceptionType.unknown,
        ),
      );
    }

    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final data = json.decode(jsonString);

      if (options.path.startsWith('/api/classes/') &&
          options.path != '/api/classes') {
        final classId = options.path.split('/').last;
        final details = (data as Map<String, dynamic>)['details'] as Map<String, dynamic>;
        final detail = details[classId];
        if (detail == null) {
          throw const ServerException('Turma não encontrada');
        }
        return handler.resolve(
          Response(requestOptions: options, statusCode: 200, data: detail),
        );
      }

      return handler.resolve(
        Response(requestOptions: options, statusCode: 200, data: data),
      );
    } on Exception catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          message: e.toString(),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  String? _resolveAssetPath(String path) {
    if (path.startsWith('/api/classes/') && path != '/api/classes') {
      return 'assets/mock/class_detail.json';
    }
    for (final entry in _routeAssets.entries) {
      if (path == entry.key || path.startsWith('${entry.key}/')) {
        return entry.value;
      }
    }
    return _routeAssets[path];
  }
}

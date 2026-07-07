import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/services/session_service.dart';
import 'package:duda_educational_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:duda_educational_flutter/features/auth/domain/entities/user.dart';
import 'package:duda_educational_flutter/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource, this._sessionService);

  final AuthRemoteDataSource _dataSource;
  final SessionService _sessionService;

  @override
  Future<User> login({required String email, required String password}) async {
    final data = await _dataSource.login(email: email, password: password);
    final token = data['token'] as String;
    final userId = data['userId'] as String;

    _sessionService.login(token: token, userId: userId);

    return User(
      id: userId,
      token: token,
      email: email,
    );
  }

  @override
  Future<bool> checkSession() async => _sessionService.isLoggedIn;

  @override
  Future<void> logout() async {
    _sessionService.logout();
  }
}

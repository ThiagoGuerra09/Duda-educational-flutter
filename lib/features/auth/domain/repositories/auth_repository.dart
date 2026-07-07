import 'package:duda_educational_flutter/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});

  Future<bool> checkSession();

  Future<void> logout();
}

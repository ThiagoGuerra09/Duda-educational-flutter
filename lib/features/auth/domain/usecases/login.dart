import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/auth/domain/entities/user.dart';
import 'package:duda_educational_flutter/features/auth/domain/repositories/auth_repository.dart';

@injectable
class Login {
  const Login(this._repository);

  final AuthRepository _repository;

  Future<User> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}

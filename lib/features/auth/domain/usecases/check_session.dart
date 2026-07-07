import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/auth/domain/repositories/auth_repository.dart';

@injectable
class CheckSession {
  const CheckSession(this._repository);

  final AuthRepository _repository;

  Future<bool> call() => _repository.checkSession();
}

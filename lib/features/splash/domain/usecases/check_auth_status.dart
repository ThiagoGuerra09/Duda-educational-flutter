import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/auth/domain/usecases/check_session.dart';

@injectable
class CheckAuthStatus {
  const CheckAuthStatus(this._checkSession);

  final CheckSession _checkSession;

  Future<bool> call() => _checkSession();
}

import 'package:injectable/injectable.dart';

@lazySingleton
class SessionService {
  String? _token;
  String? _userId;

  bool get isLoggedIn => _token != null;

  String? get token => _token;
  String? get userId => _userId;

  void login({required String token, required String userId}) {
    _token = token;
    _userId = userId;
  }

  void logout() {
    _token = null;
    _userId = null;
  }
}

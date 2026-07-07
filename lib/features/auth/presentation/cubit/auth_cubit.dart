import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/auth/domain/entities/user.dart';
import 'package:duda_educational_flutter/features/auth/domain/usecases/check_session.dart';
import 'package:duda_educational_flutter/features/auth/domain/usecases/login.dart';
import 'package:duda_educational_flutter/features/auth/domain/usecases/logout.dart';
import 'package:duda_educational_flutter/features/auth/presentation/cubit/auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._login, this._checkSession, this._logout)
      : super(const AuthState.initial());

  final Login _login;
  final CheckSession _checkSession;
  final Logout _logout;

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    try {
      final user = await _login(email: email, password: password);
      emit(AuthState.authenticated(user));
    } on Failure catch (e) {
      emit(AuthState.failure(e.message));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> checkSession() async {
    emit(const AuthState.loading());
    try {
      final isLoggedIn = await _checkSession();
      if (isLoggedIn) {
        emit(const AuthState.authenticated(
          User(id: 'session', token: 'session'),
        ));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> logout() async {
    await _logout();
    emit(const AuthState.unauthenticated());
  }
}

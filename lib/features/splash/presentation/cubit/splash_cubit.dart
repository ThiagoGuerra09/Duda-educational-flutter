import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/splash/domain/usecases/check_auth_status.dart';
import 'package:duda_educational_flutter/features/splash/presentation/cubit/splash_state.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/durations.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._checkAuthStatus) : super(const SplashState.initial());

  final CheckAuthStatus _checkAuthStatus;

  Future<void> checkAuth() async {
    emit(const SplashState.loading());
    await Future<void>.delayed(AppDurations.splash);
    final isAuthenticated = await _checkAuthStatus();
    if (isAuthenticated) {
      emit(const SplashState.authenticated());
    } else {
      emit(const SplashState.unauthenticated());
    }
  }
}

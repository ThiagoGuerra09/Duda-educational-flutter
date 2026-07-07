import 'package:equatable/equatable.dart';

enum SplashStatus { initial, loading, authenticated, unauthenticated }

class SplashState extends Equatable {
  const SplashState({this.status = SplashStatus.initial});

  const SplashState.initial() : this();

  const SplashState.loading() : this(status: SplashStatus.loading);

  const SplashState.authenticated()
      : this(status: SplashStatus.authenticated);

  const SplashState.unauthenticated()
      : this(status: SplashStatus.unauthenticated);

  final SplashStatus status;

  @override
  List<Object?> get props => [status];
}

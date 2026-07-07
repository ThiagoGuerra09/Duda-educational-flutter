import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erro no servidor']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Erro de cache']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Erro de conexão']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Credenciais inválidas']);
}

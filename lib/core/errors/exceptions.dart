class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException([super.message = 'Erro no servidor']);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'Erro de conexão']);
}

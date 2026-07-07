import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';

Failure mapExceptionToFailure(Object error) {
  if (error is ServerException) {
    return ServerFailure(error.message);
  }
  if (error is NetworkException) {
    return NetworkFailure(error.message);
  }
  if (error is AuthFailure) {
    return error;
  }
  return ServerFailure(error.toString());
}

T handleError<T>(Object error) {
  throw mapExceptionToFailure(error);
}

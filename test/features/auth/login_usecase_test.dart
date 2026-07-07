import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:duda_educational_flutter/features/auth/domain/entities/user.dart';
import 'package:duda_educational_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:duda_educational_flutter/features/auth/domain/usecases/login.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late Login login;

  setUp(() {
    repository = MockAuthRepository();
    login = Login(repository);
  });

  test('Login calls repository with email and password', () async {
    const user = User(id: '1', token: 'token', email: 'a@b.com');
    when(
      () => repository.login(email: any(named: 'email'), password: any(named: 'password')),
    ).thenAnswer((_) async => user);

    final result = await login(email: 'a@b.com', password: '123');

    expect(result, user);
    verify(() => repository.login(email: 'a@b.com', password: '123')).called(1);
  });
}

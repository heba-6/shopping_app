import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart';

class MockAuthRepo extends Mock implements AuthRepoInterface {}

void main() {
  late MockAuthRepo mockAuthRepo;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    loginUseCase = LoginUseCase(mockAuthRepo);
  });

  group('LoginUseCase', () {
    const email = 'test@example.com';
    const password = '123456';

    test('should return Success when login succeeds', () async {
      // Arrange
      final loginResponse = LoginResponseEntity(
        message: 'Login successful',
        token: 'abc123',
      );

      final expectedResult = Success<LoginResponseEntity>(loginResponse);

      when(
        () => mockAuthRepo.login(email: email, password: password),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await loginUseCase.invoke(
        email: email,
        password: password,
      );

      // Assert
      expect(result, isA<Success<LoginResponseEntity>>());
      expect(
        (result as Success<LoginResponseEntity>).data,
        same(loginResponse),
      );

      verify(
        () => mockAuthRepo.login(email: email, password: password),
      ).called(1);
    });

    test('should return Error when login fails', () async {
      // Arrange
      final expectedResult = Error<LoginResponseEntity>(
        'Invalid email or password',
      );

      when(
        () => mockAuthRepo.login(email: email, password: password),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await loginUseCase.invoke(
        email: email,
        password: password,
      );

      // Assert
      expect(result, isA<Error<LoginResponseEntity>>());
      expect(
        (result as Error<LoginResponseEntity>).messageError,
        'Invalid email or password',
      );

      verify(
        () => mockAuthRepo.login(email: email, password: password),
      ).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';
import 'package:shopping_app/features/account/domain/use_case/get_user_profile_use_case.dart';

class MockAccountRepo extends Mock implements AccountRepoInterface {}

void main() {
  late MockAccountRepo mockAccountRepo;
  late GetUserProfileUseCase useCase;

  setUp(() {
    mockAccountRepo = MockAccountRepo();
    useCase = GetUserProfileUseCase(mockAccountRepo);
  });

  group('GetUserProfileUseCase', () {
    test('should return Success when getting user profile succeeds', () async {
      // Arrange
      final userProfile = FakeUserProfileEntity();
      final expectedResult = Success<UserProfileEntity>(userProfile);

      when(
        () => mockAccountRepo.getUserData(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Success<UserProfileEntity>>());
      expect((result as Success<UserProfileEntity>).data, same(userProfile));

      verify(() => mockAccountRepo.getUserData()).called(1);
    });

    test('should return Error when getting user profile fails', () async {
      // Arrange
      final expectedResult = Error<UserProfileEntity>(
        'Failed to get user profile',
      );

      when(
        () => mockAccountRepo.getUserData(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Error<UserProfileEntity>>());
      expect(
        (result as Error<UserProfileEntity>).messageError,
        'Failed to get user profile',
      );

      verify(() => mockAccountRepo.getUserData()).called(1);
    });
  });
}

class FakeUserProfileEntity extends Fake implements UserProfileEntity {}

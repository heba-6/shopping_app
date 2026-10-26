import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';
import 'package:shopping_app/features/account/domain/use_case/update_user_profile_use_case.dart';

class MockAccountRepo extends Mock implements AccountRepoInterface {}

class FakeUserProfileEntity extends Fake implements UserProfileEntity {}

void main() {
  late MockAccountRepo mockAccountRepo;
  late UpdateUserProfileUseCase useCase;

  setUp(() {
    mockAccountRepo = MockAccountRepo();
    useCase = UpdateUserProfileUseCase(mockAccountRepo);
  });

  group('UpdateUserProfileUseCase', () {
    const name = 'Heba Mahmoud';
    const phone = '01012345678';
    const address = 'Cairo, Egypt';
    const image = 'profile.jpg';

    test('should return Success when updating profile succeeds', () async {
      // Arrange
      final userProfile = FakeUserProfileEntity();
      final expectedResult = Success<UserProfileEntity>(userProfile);

      when(
        () => mockAccountRepo.updateUserData(
          name: name,
          phone: phone,
          address: address,
          image: image,
          imageFile: null,
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase(
        name: name,
        phone: phone,
        address: address,
        image: image,
      );

      // Assert
      expect(result, isA<Success<UserProfileEntity>>());
      expect((result as Success<UserProfileEntity>).data, same(userProfile));

      verify(
        () => mockAccountRepo.updateUserData(
          name: name,
          phone: phone,
          address: address,
          image: image,
          imageFile: null,
        ),
      ).called(1);
    });

    test('should return Error when updating profile fails', () async {
      // Arrange
      final expectedResult = Error<UserProfileEntity>(
        'Failed to update user profile',
      );

      when(
        () => mockAccountRepo.updateUserData(
          name: name,
          phone: phone,
          address: address,
          image: image,
          imageFile: null,
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase(
        name: name,
        phone: phone,
        address: address,
        image: image,
      );

      // Assert
      expect(result, isA<Error<UserProfileEntity>>());
      expect(
        (result as Error<UserProfileEntity>).messageError,
        'Failed to update user profile',
      );

      verify(
        () => mockAccountRepo.updateUserData(
          name: name,
          phone: phone,
          address: address,
          image: image,
          imageFile: null,
        ),
      ).called(1);
    });
  });
}

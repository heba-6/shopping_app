import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:shopping_app/features/favourite/domain/use_case/remove_favourite_use_case.dart';

class MockFavouriteRepo extends Mock implements FavouriteRepoInterface {}

void main() {
  late MockFavouriteRepo mockFavouriteRepo;
  late RemoveFavouriteUseCase useCase;

  setUp(() {
    mockFavouriteRepo = MockFavouriteRepo();
    useCase = RemoveFavouriteUseCase(mockFavouriteRepo);
  });

  group('RemoveFavouriteUseCase', () {
    const productId = 5;

    test('should return Success when removing favourite succeeds', () async {
      // Arrange
      final expectedResult = Success<void>(null);

      when(
        () => mockFavouriteRepo.removeFromFavourite(productId: productId),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase(productId: productId);

      // Assert
      expect(result, isA<Success<void>>());
      expect(result, same(expectedResult));

      verify(
        () => mockFavouriteRepo.removeFromFavourite(productId: productId),
      ).called(1);
    });

    test('should return Error when removing favourite fails', () async {
      // Arrange
      final expectedResult = Error<void>('Failed to remove favourite');

      when(
        () => mockFavouriteRepo.removeFromFavourite(productId: productId),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase(productId: productId);

      // Assert
      expect(result, isA<Error<void>>());
      expect(
        (result as Error<void>).messageError,
        'Failed to remove favourite',
      );

      verify(
        () => mockFavouriteRepo.removeFromFavourite(productId: productId),
      ).called(1);
    });
  });
}

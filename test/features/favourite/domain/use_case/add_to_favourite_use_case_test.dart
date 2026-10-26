import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:shopping_app/features/favourite/domain/use_case/add_to_favourite_use_case.dart';

class MockFavouriteRepo extends Mock implements FavouriteRepoInterface {}

void main() {
  late MockFavouriteRepo mockFavouriteRepo;
  late AddToFavouriteUseCase useCase;

  setUp(() {
    mockFavouriteRepo = MockFavouriteRepo();
    useCase = AddToFavouriteUseCase(mockFavouriteRepo);
  });

  group('AddToFavouriteUseCase', () {
    const productId = 5;

    test(
      'should return Success when adding product to favourite succeeds',
      () async {
        // Arrange
        final expectedResult = Success<void>(null);

        when(
          () => mockFavouriteRepo.addToFavourite(productId: productId),
        ).thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase(productId: productId);

        // Assert
        expect(result, isA<Success<void>>());
        expect(result, same(expectedResult));

        verify(
          () => mockFavouriteRepo.addToFavourite(productId: productId),
        ).called(1);
      },
    );

    test(
      'should return Error when adding product to favourite fails',
      () async {
        // Arrange
        final expectedResult = Error<void>(
          'Failed to add product to favourite',
        );

        when(
          () => mockFavouriteRepo.addToFavourite(productId: productId),
        ).thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase(productId: productId);

        // Assert
        expect(result, isA<Error<void>>());
        expect(
          (result as Error<void>).messageError,
          'Failed to add product to favourite',
        );

        verify(
          () => mockFavouriteRepo.addToFavourite(productId: productId),
        ).called(1);
      },
    );
  });
}

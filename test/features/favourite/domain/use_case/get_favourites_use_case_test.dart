import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:shopping_app/features/favourite/domain/use_case/get_favourites_use_case.dart';

class MockFavouriteRepo extends Mock implements FavouriteRepoInterface {}

class FakeProductsEntity extends Fake implements ProductsEntity {}

void main() {
  late MockFavouriteRepo mockFavouriteRepo;
  late GetFavouritesUseCase useCase;

  setUp(() {
    mockFavouriteRepo = MockFavouriteRepo();
    useCase = GetFavouritesUseCase(mockFavouriteRepo);
  });

  group('GetFavouritesUseCase', () {
    test('should return Success when getting favourites succeeds', () async {
      // Arrange
      final products = <ProductsEntity>[
        FakeProductsEntity(),
        FakeProductsEntity(),
      ];

      final expectedResult = Success<List<ProductsEntity>>(products);

      when(
        () => mockFavouriteRepo.getFavourites(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Success<List<ProductsEntity>>>());
      expect((result as Success<List<ProductsEntity>>).data, same(products));

      verify(() => mockFavouriteRepo.getFavourites()).called(1);
    });

    test('should return Error when getting favourites fails', () async {
      // Arrange
      final expectedResult = Error<List<ProductsEntity>>(
        'Failed to get favourites',
      );

      when(
        () => mockFavouriteRepo.getFavourites(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Error<List<ProductsEntity>>>());
      expect(
        (result as Error<List<ProductsEntity>>).messageError,
        'Failed to get favourites',
      );

      verify(() => mockFavouriteRepo.getFavourites()).called(1);
    });
  });
}

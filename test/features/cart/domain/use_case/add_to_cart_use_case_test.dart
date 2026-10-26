import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:shopping_app/features/cart/domain/use_case/add_to_cart_use_case.dart';

class MockCartRepo extends Mock implements CartRepoInterface {}

void main() {
  late MockCartRepo mockCartRepo;
  late AddToCartUseCase useCase;

  setUp(() {
    mockCartRepo = MockCartRepo();
    useCase = AddToCartUseCase(mockCartRepo);
  });

  group('AddToCartUseCase', () {
    const productId = 5;

    test('should return Success when adding product succeeds', () async {
      // Arrange
      final expectedResult = Success<void>(null);

      when(
        () => mockCartRepo.addToCart(productId: productId),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase(productId: productId);

      // Assert
      expect(result, same(expectedResult));
    });

    test('should return Error when adding product fails', () async {
      // Arrange
      final expectedResult = Error<void>('Failed to add product');

      when(
        () => mockCartRepo.addToCart(productId: productId),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase(productId: productId);

      // Assert
      expect(result, same(expectedResult));
    });
  });
}

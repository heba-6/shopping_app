import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:shopping_app/features/cart/domain/use_case/get_cart_use_case.dart';

class MockCartRepo extends Mock implements CartRepoInterface {}

void main() {
  late MockCartRepo mockCartRepo;
  late GetCartUseCase useCase;

  setUp(() {
    mockCartRepo = MockCartRepo();
    useCase = GetCartUseCase(mockCartRepo);
  });

  group('GetCartUseCase', () {
    test('should return Success when getting cart succeeds', () async {
      // Arrange
      final expectedResult = Success<List<CartItemEntity>>([]);

      when(
        () => mockCartRepo.getCart(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase();

      // Assert
      expect(result, same(expectedResult));
      verify(() => mockCartRepo.getCart()).called(1);
    });

    test('should return Error when getting cart fails', () async {
      // Arrange
      final expectedResult = Error<List<CartItemEntity>>('Failed to get cart');

      when(
        () => mockCartRepo.getCart(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase();

      // Assert
      expect(result, same(expectedResult));
      verify(() => mockCartRepo.getCart()).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_product_use_case.dart';

class MockHomeRepo extends Mock implements HomeRepoInterface {}

class FakeProductResponseEntity extends Fake implements ProductResponseEntity {}

void main() {
  late MockHomeRepo mockHomeRepo;
  late GetAllProductUseCase useCase;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    useCase = GetAllProductUseCase(mockHomeRepo);
  });

  group('GetAllProductUseCase', () {
    const skip = 0;
    const limit = 10;

    test('should return Success when getting products succeeds', () async {
      // Arrange
      final productResponse = FakeProductResponseEntity();
      final expectedResult = Success<ProductResponseEntity>(productResponse);

      when(
        () => mockHomeRepo.getallproduct(skip: skip, limit: limit),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase.invoke(skip: skip, limit: limit);

      // Assert
      expect(result, isA<Success<ProductResponseEntity>>());
      expect(
        (result as Success<ProductResponseEntity>).data,
        same(productResponse),
      );

      verify(
        () => mockHomeRepo.getallproduct(skip: skip, limit: limit),
      ).called(1);
    });

    test('should return Error when getting products fails', () async {
      // Arrange
      final expectedResult = Error<ProductResponseEntity>(
        'Failed to get products',
      );

      when(
        () => mockHomeRepo.getallproduct(skip: skip, limit: limit),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase.invoke(skip: skip, limit: limit);

      // Assert
      expect(result, isA<Error<ProductResponseEntity>>());
      expect(
        (result as Error<ProductResponseEntity>).messageError,
        'Failed to get products',
      );

      verify(
        () => mockHomeRepo.getallproduct(skip: skip, limit: limit),
      ).called(1);
    });
  });
}

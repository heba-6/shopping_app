import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/features/products_by_category/domain/entities/products_by_category_page_entity.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_repo_interface.dart';
import 'package:shopping_app/features/products_by_category/domain/use_case/get_products_by_category_use_case.dart';

class MockProductsByCategoryRepo extends Mock
    implements ProductsByCategoryRepoInterface {}

class FakeProductsByCategoryPageEntity extends Fake
    implements ProductsByCategoryPageEntity {}

void main() {
  late MockProductsByCategoryRepo mockRepo;
  late GetProductsByCategoryUseCase useCase;

  setUp(() {
    mockRepo = MockProductsByCategoryRepo();
    useCase = GetProductsByCategoryUseCase(repo: mockRepo);
  });

  group('GetProductsByCategoryUseCase', () {
    const slug = 'electronics';
    const skip = 0;
    const limit = 10;

    test('should return products page when request succeeds', () async {
      // Arrange
      final expectedPage = FakeProductsByCategoryPageEntity();

      when(
        () => mockRepo.getProductsByCategory(slug, skip: skip, limit: limit),
      ).thenAnswer((_) async => expectedPage);

      // Act
      final result = await useCase(slug, skip: skip, limit: limit);

      // Assert
      expect(result, same(expectedPage));

      verify(
        () => mockRepo.getProductsByCategory(slug, skip: skip, limit: limit),
      ).called(1);
    });

    test('should throw exception when request fails', () async {
      // Arrange
      final exception = Exception('Failed to get category products');

      when(
        () => mockRepo.getProductsByCategory(slug, skip: skip, limit: limit),
      ).thenAnswer((_) => Future.error(exception));

      // Act & Assert
      await expectLater(
        useCase(slug, skip: skip, limit: limit),
        throwsA(same(exception)),
      );

      verify(
        () => mockRepo.getProductsByCategory(slug, skip: skip, limit: limit),
      ).called(1);
    });
  });
}

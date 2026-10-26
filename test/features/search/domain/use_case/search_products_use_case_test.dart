import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/features/search/domain/entities/search_page_entity.dart';
import 'package:shopping_app/features/search/domain/repo/search_repo_interface.dart';
import 'package:shopping_app/features/search/domain/use_case/search_products_use_case.dart';

class MockSearchRepo extends Mock implements SearchRepoInterface {}

class FakeSearchPageEntity extends Fake implements SearchPageEntity {}

void main() {
  late MockSearchRepo mockSearchRepo;
  late SearchProductsUseCase useCase;

  setUp(() {
    mockSearchRepo = MockSearchRepo();
    useCase = SearchProductsUseCase(mockSearchRepo);
  });

  group('SearchProductsUseCase', () {
    const query = 'phone';

    test('should return search results when search succeeds', () async {
      // Arrange
      final expectedPage = FakeSearchPageEntity();

      when(
        () => mockSearchRepo.searchProducts(query),
      ).thenAnswer((_) async => expectedPage);

      // Act
      final result = await useCase(query);

      // Assert
      expect(result, same(expectedPage));

      verify(() => mockSearchRepo.searchProducts(query)).called(1);
    });

    test('should throw exception when search fails', () async {
      // Arrange
      final exception = Exception('Failed to search products');

      when(
        () => mockSearchRepo.searchProducts(query),
      ).thenAnswer((_) => Future.error(exception));

      // Act & Assert
      await expectLater(useCase(query), throwsA(same(exception)));

      verify(() => mockSearchRepo.searchProducts(query)).called(1);
    });
  });
}

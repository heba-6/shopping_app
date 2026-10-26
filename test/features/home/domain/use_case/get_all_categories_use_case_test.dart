import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_categories_use_case.dart';

class MockHomeRepo extends Mock implements HomeRepoInterface {}

class FakeCategoryEntity extends Fake implements CategoryEntity {}

void main() {
  late MockHomeRepo mockHomeRepo;
  late GetAllCategoriesUseCase useCase;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    useCase = GetAllCategoriesUseCase(mockHomeRepo);
  });

  group('GetAllCategoriesUseCase', () {
    test('should return Success when getting categories succeeds', () async {
      // Arrange
      final categories = <CategoryEntity>[
        FakeCategoryEntity(),
        FakeCategoryEntity(),
      ];

      final expectedResult = Success<List<CategoryEntity>>(categories);

      when(
        () => mockHomeRepo.getAllCategories(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase.invoke();

      // Assert
      expect(result, isA<Success<List<CategoryEntity>>>());
      expect((result as Success<List<CategoryEntity>>).data, same(categories));

      verify(() => mockHomeRepo.getAllCategories()).called(1);
    });

    test('should return Error when getting categories fails', () async {
      // Arrange
      final expectedResult = Error<List<CategoryEntity>>(
        'Failed to get categories',
      );

      when(
        () => mockHomeRepo.getAllCategories(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await useCase.invoke();

      // Assert
      expect(result, isA<Error<List<CategoryEntity>>>());
      expect(
        (result as Error<List<CategoryEntity>>).messageError,
        'Failed to get categories',
      );

      verify(() => mockHomeRepo.getAllCategories()).called(1);
    });
  });
}

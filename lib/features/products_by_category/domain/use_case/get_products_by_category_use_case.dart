import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/products_by_category_page_entity.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_repo_interface.dart';

@injectable
class GetProductsByCategoryUseCase {
  final ProductsByCategoryRepoInterface _repo;

  GetProductsByCategoryUseCase({required ProductsByCategoryRepoInterface repo})
    : _repo = repo;

  Future<ProductsByCategoryPageEntity> call(
    String slug, {
    required int skip,
    int limit = 10,
  }) {
    return _repo.getProductsByCategory(slug, skip: skip, limit: limit);
  }
}

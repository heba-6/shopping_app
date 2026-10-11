import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_repo_interface.dart';

@injectable
class GetProductsByCategoryUseCase {
  final ProductsByCategoryRepoInterface _repo;

  GetProductsByCategoryUseCase({required ProductsByCategoryRepoInterface repo})
    : _repo = repo;

  Future<List<ProductByCategoryEntity>> call(String slug) {
    return _repo.getProductsByCategory(slug);
  }
}

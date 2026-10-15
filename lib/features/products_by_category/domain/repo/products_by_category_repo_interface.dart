import 'package:shopping_app/features/products_by_category/domain/entities/products_by_category_page_entity.dart';

abstract class ProductsByCategoryRepoInterface {
  Future<ProductsByCategoryPageEntity> getProductsByCategory(
    String slug, {
    required int skip,
    int limit = 10,
  });
}

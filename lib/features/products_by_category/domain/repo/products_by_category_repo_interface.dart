import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';

abstract class ProductsByCategoryRepoInterface {
  Future<List<ProductByCategoryEntity>> getProductsByCategory(String slug);
}

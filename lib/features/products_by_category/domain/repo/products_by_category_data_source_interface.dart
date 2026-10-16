import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/products_by_category_page_entity.dart';

abstract class ProductsByCategoryDataSourceInterface {
  Future<ResultApi<ProductsByCategoryPageEntity>> getProductsByCategory(
    String slug, {
    required int skip,
    int limit = 10,
  });
}

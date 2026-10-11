import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';

abstract class ProductsByCategoryDataSourceInterface {
  Future<ResultApi<List<ProductByCategoryEntity>>> getProductsByCategory(
    String slug,
  );
}

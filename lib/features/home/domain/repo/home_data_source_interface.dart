import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

abstract class HomeDataSourceInterface {
  Future<ResultApi<ProductResponseEntity>> getallproduct({
    required int skip,
    int limit = 10,
  });

  Future<ResultApi<List<CategoryEntity>>> getAllCategories();
}

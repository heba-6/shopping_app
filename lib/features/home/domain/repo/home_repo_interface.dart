import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

abstract interface class HomeRepoInterface {
  Future<ResultApi<ProductResponseEntity>> getallproduct({
    required int skip,
    int limit = 10,
  });

  Future<ResultApi<List<CategoryEntity>>> getAllCategories();
}

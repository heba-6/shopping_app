import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';

abstract class HomeDataSourceInterface {
  Future<ResultApi<ProductResponseEntity>> getallproduct();
}

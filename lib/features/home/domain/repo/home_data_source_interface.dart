import 'package:shopping_app/features/home/data/model/product_Response_dto.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart.dart';

abstract class HomeDataSourceInterface {
  Future<ResultApi<ProductResponseEntity>> getallproduct();
}

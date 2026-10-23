import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/data/model/cart_dto.dart';

abstract class CartDataSourceInterface {
  Future<ResultApi<List<CartDto>>> getCart();

  Future<ResultApi<void>> addToCart({required int productId});

  Future<ResultApi<void>> deleteCartItem({required int productId});
}

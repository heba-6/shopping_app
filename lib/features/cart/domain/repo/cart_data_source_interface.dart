import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartDataSourceInterface {
  Future<ResultApi<List<CartItemEntity>>> getCart();

  Future<ResultApi<void>> addToCart({required int productId});

  Future<ResultApi<void>> deleteCartItem({required int productId});
}

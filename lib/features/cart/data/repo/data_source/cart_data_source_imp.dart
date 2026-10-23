import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/data/api/cart_api.dart';
import 'package:shopping_app/features/cart/data/model/cart_dto.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';

@Injectable(as: CartDataSourceInterface)
class CartDataSourceImp implements CartDataSourceInterface {
  final CartApi _api;

  CartDataSourceImp(this._api);

  @override
  Future<ResultApi<List<CartDto>>> getCart() async {
    try {
      final response = await _api.getCart();

      dynamic items =
          response['items'] ??
          response['cart'] ??
          response['products'] ??
          response['data'];

      if (items is Map<String, dynamic>) {
        items =
            items['items'] ??
            items['cart'] ??
            items['products'] ??
            items['data'];
      }

      if (items is! List) {
        return Error('Invalid cart response format');
      }

      final cartItems = items
          .whereType<Map>()
          .map((item) => CartDto.fromJson(Map<String, dynamic>.from(item)))
          .toList();

      return Success(cartItems);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> addToCart({required int productId}) async {
    try {
      await _api.addToCart(productId: productId);
      return Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> deleteCartItem({required int productId}) async {
    try {
      await _api.deleteCartItem(productId: productId);
      return Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

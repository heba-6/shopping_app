import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/data/api/cart_api.dart';
import 'package:shopping_app/features/cart/data/model/cart_dto.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';

@LazySingleton(as: CartDataSourceInterface)
class CartDataSourceImp implements CartDataSourceInterface {
  final CartApi _api;

  CartDataSourceImp(this._api);

  @override
  Future<ResultApi<List<CartItemEntity>>> getCart() async {
    try {
      final json = await _api.getCart();

      final rawList = json['list'];

      if (rawList != null && rawList is! List) {
        return Error<List<CartItemEntity>>('Invalid cart items format');
      }

      final items = rawList as List<dynamic>? ?? [];

      final cartItems = items.map((item) {
        if (item is! Map) {
          throw const FormatException('Invalid cart item format');
        }

        return CartDto.fromJson(Map<String, dynamic>.from(item)).toEntity();
      }).toList();

      return Success<List<CartItemEntity>>(cartItems);
    } catch (e) {
      return Error<List<CartItemEntity>>(_errorMessage(e));
    }
  }

  @override
  Future<ResultApi<void>> addToCart({required int productId}) async {
    try {
      await _api.addToCart(productId: productId);

      return Success<void>(null);
    } catch (e) {
      return Error<void>(_errorMessage(e));
    }
  }

  @override
  Future<ResultApi<void>> deleteCartItem({required int productId}) async {
    try {
      await _api.deleteCartItem(productId: productId);

      return Success<void>(null);
    } catch (e) {
      return Error<void>(_errorMessage(e));
    }
  }

  String _errorMessage(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;

      if (responseData is Map) {
        final message = responseData['message'];

        if (message != null) {
          return message.toString();
        }
      }

      if (error.response?.statusCode != null) {
        return 'Request failed with status '
            '${error.response!.statusCode}';
      }

      return error.message ?? 'Network error';
    }

    return error.toString();
  }
}

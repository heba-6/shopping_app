import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constant.dart';

@lazySingleton
class CartApi {
  final Dio _dio;

  CartApi(this._dio);

  Future<Map<String, dynamic>> getCart() async {
    final response = await _dio.get(ApiConstants.getCart);

    final data = response.data;

    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    throw const FormatException('Invalid cart response format');
  }

  Future<void> addToCart({required int productId}) async {
    await _dio.post(ApiConstants.addCart, data: {'productId': productId});
  }

  Future<void> deleteCartItem({required int productId}) async {
    await _dio.delete(ApiConstants.deleteCart, data: {'productId': productId});
  }
}

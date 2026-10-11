import 'package:dio/dio.dart';

class ProductsByCategoryApi {
  final Dio _dio;

  ProductsByCategoryApi({
    required Dio dio,
  }) : _dio = dio;

  Future<Response> getProductsByCategory(
    String slug,
  ) async {
    return await _dio.get(
      '/home/products/category/$slug',
      queryParameters: {
        'skip': 0,
        'limit': 5,
      },
    );
  }
}
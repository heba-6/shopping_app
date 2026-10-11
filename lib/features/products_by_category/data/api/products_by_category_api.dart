import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductsByCategoryApi {
  final Dio _dio;

  ProductsByCategoryApi(this._dio);

  Future<Map<String, dynamic>> getProductsByCategory(String slug) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/home/products/category/$slug',
      queryParameters: {'skip': 0, 'limit': 5},
    );

    if (response.data == null) {
      throw Exception('The API returned an empty response');
    }

    return response.data!;
  }
}

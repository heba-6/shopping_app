import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Api {
  final Dio _dio;

  Api(this._dio);

  Future<Map<String, dynamic>> getAllProducts() async {
    final response = await _dio.get(
      '/home/products',
      queryParameters: {'skip': 0, 'limit': 5},
    );

    return Map<String, dynamic>.from(response.data);
  }
}

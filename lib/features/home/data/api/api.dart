import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Api {
  final Dio _dio;

  Api(this._dio);

  Future<Map<String, dynamic>> getAllProducts({
    required int skip,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/home/products',
        queryParameters: {'skip': skip, 'limit': limit},
      );

      if (response.data == null) {
        throw Exception('The API returned an empty response');
      }

      return response.data!;
    } on DioException catch (e) {
      log('Products status: ${e.response?.statusCode}');
      log('Products response: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAllCategories() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/home/categories');

      if (response.data == null) {
        throw Exception('The API returned an empty response');
      }

      return response.data!;
    } on DioException catch (e) {
      log('Categories status: ${e.response?.statusCode}');
      log('Categories response: ${e.response?.data}');
      rethrow;
    }
  }
}

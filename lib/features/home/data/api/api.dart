import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/auth_interceptor.dart';
import 'package:shopping_app/core/storage/token_storage.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://supermarket-dan1.onrender.com/api/v1',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(AuthInterceptor(TokenStorage()));

    return dio;
  }
}

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

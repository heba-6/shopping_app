import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constant.dart';

@lazySingleton
class SearchApi {
  final Dio _dio;

  SearchApi(this._dio);

  Future<Map<String, dynamic>> searchProducts(String query) async {
    final searchQuery = query.trim();

    try {
      debugPrint('Search API query: "$searchQuery"');
      debugPrint('Search API URL: ${ApiConstants.search}');

      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.search,
        data: {'query': searchQuery},
      );

      debugPrint('Search API status: ${response.statusCode}');
      debugPrint('Search API response: ${response.data}');

      if (response.data == null) {
        throw Exception('The API returned an empty response');
      }

      return response.data!;
    } on DioException catch (e) {
      debugPrint('Search API error: ${e.response?.statusCode}');
      debugPrint('Search API error body: ${e.response?.data}');
      rethrow;
    }
  }
}

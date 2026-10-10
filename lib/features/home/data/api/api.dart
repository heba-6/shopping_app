import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: 'https://supermarket-dan1.onrender.com/api/v1',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
}

@lazySingleton
class Api {
  final Dio _dio;

  Api(this._dio);

  Future<Map<String, dynamic>> getAllProducts() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/home/products',
        queryParameters: {'skip': 0, 'limit': 10},
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhYzU5MjNjYjMwZmIxZjQ3OGViYjI4YSIsImlhdCI6MTc5MTMzMjk1NywiZXhwIjoxNzkzOTI0OTU3fQ._J0AxP7zz5fqIX0GWCvZ0Q8AUhwr5I-Jet-twi9q14A',
          },
        ),
      );

      if (response.data == null) {
        throw Exception('The API returned an empty response');
      }

      return response.data!;
    } on DioException catch (e) {
      print('REQUEST URL: ${e.requestOptions.uri}');
      print('STATUS CODE: ${e.response?.statusCode}');
      print('SERVER RESPONSE: ${e.response?.data}');
      rethrow;
    }
  }
}

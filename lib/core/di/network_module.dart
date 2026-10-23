import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://supermarket-dan1.onrender.com/api/v1',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          const token =
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhYzU5MjNjYjMwZmIxZjQ3OGViYjI4YSIsImlhdCI6MTc5MTY1MTA0NSwiZXhwIjoxNzk0MjQzMDQ1fQ.j4AOpvVMlcskmgBfRNhqz2bPZRaWKYUmLtqWn6B1OK8';
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
      ),
    );

    return dio;
  }
}

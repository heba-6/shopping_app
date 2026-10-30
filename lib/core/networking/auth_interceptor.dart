import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/storage/token_storage.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _tokenStorage.getToken();

      final hasToken = token != null && token.trim().isNotEmpty;

      log('TOKEN EXISTS: $hasToken');
      log('TOKEN LENGTH: ${token?.trim().length ?? 0}');

      if (hasToken) {
        options.headers['Authorization'] = 'Bearer ${token.trim()}';
      } else {
        options.headers.remove('Authorization');
      }

      handler.next(options);
    } catch (error, stackTrace) {
      log(
        'Failed to retrieve authentication token',
        error: error,
        stackTrace: stackTrace,
      );

      handler.reject(DioException(requestOptions: options, error: error));
    }
  }
}

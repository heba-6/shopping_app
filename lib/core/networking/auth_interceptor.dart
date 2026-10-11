// import 'package:dio/dio.dart';
// import 'package:shopping_app/core/storage/token_storage.dart';

// class AuthInterceptor extends Interceptor {
//   final TokenStorage _tokenStorage;

//   AuthInterceptor(this._tokenStorage);

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     try {
//       final token = await _tokenStorage.getToken();

//       if (token != null && token.trim().isNotEmpty) {
//         options.headers['Authorization'] = 'Bearer ${token.trim()}';

//         print('TOKEN EXISTS: true');
//         print('TOKEN LENGTH: ${token.trim().length}');
//       } else {
//         options.headers.remove('Authorization');
//         print('TOKEN EXISTS: false');
//       }

//       print(
//         'AUTH HEADER ADDED: '
//         '${options.headers.containsKey('Authorization')}',
//       );

//       handler.next(options);
//     } catch (error) {
//       print('TOKEN ERROR: $error');

//       handler.reject(DioException(requestOptions: options, error: error));
//     }
//   }
// }

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

      if (token != null && token.trim().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${token.trim()}';
      } else {
        options.headers.remove('Authorization');
      }

      handler.next(options);
    } catch (error) {
      handler.reject(DioException(requestOptions: options, error: error));
    }
  }
}

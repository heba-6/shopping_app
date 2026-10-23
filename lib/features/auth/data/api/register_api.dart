import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../model/register_request_model.dart';

@lazySingleton
class RegisterApi {
  final Dio _dio;
  RegisterApi(this._dio);

  Future<Map<String, dynamic>> register(RegisterRequestModel request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/signUp',
      data: request.toJson(),
    );
    return response.data ?? {};
  }
}

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/auth/data/api/register_api.dart';
import 'package:shopping_app/features/auth/data/model/register_request_model.dart';

@lazySingleton
class RegisterRepo {
  final RegisterApi _api;
  RegisterRepo(this._api);

  Future<String> register(RegisterRequestModel request) async {
    try {
      final data = await _api.register(request);
      return data['message']?.toString() ?? 'Account created successfully';
    } on DioException catch (e) {
      final body = e.response?.data;
      if (body is Map && body['message'] != null) {
        throw Exception(body['message'].toString());
      }
      throw Exception('Network error. Please try again.');
    }
  }
}
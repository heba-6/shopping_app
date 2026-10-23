import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constant.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/auth/data/model/login_response_dto.dart';
@lazySingleton
class AuthApi {
  Future<ResultApi<LoginResponseDto>> login(
    String email,
    String password,
  ) async {
    try {
      Uri url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      var resBody = response.body;
      var json = jsonDecode(resBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(LoginResponseDto.fromJson(json));
      } else {
        log("statusCode ${response.statusCode}");
        log("Massage ${json['message']}");
        return Error("Error From server");
      }
    } on SocketException {
      return Error("Error From internet");
    } catch (e) {
      log("Error From Register Api ");
      return Error("Error From catch $e");
    }
  }
}

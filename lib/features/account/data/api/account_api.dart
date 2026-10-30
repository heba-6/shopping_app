import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountApi {
  final Dio _dio;

  AccountApi(this._dio);

  Future<Map<String, dynamic>> getUserData() async {
    final response = await _dio.get('/portfoilo/userData');

    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> updateUserData({
    required String name,
    required String phone,
    required String address,
    required String image,
  }) async {
    final response = await _dio.post(
      '/portfoilo/editUserData',
      data: {
        'name': name,
        'phone': phone,
        'address': address,
        'image': image,
      },
    );

    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
    });

    final response = await _dio.post(
      '/portfoilo/addImage',
      data: formData,
    );

    return Map<String, dynamic>.from(response.data as Map);
  }
}
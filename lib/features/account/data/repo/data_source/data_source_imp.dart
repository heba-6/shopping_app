import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/data/api/account_api.dart';
import 'package:shopping_app/features/account/data/model/user_profile_dto.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_data_source_interface.dart';

@LazySingleton(as: AccountDataSourceInterface)
class AccountDataSourceImpl implements AccountDataSourceInterface {
  final AccountApi _api;

  AccountDataSourceImpl(this._api);

  String _errorMessage(Object error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'Check your internet connection and try again.';
      }

      final code = error.response?.statusCode;

      if (code == 401 || code == 403) {
        return 'Please log in again.';
      }

      if (code != null && code >= 500) {
        return 'Server error. Please try again later.';
      }

      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
    }

    return error.toString();
  }

  Map<String, dynamic> _unwrap(Map<String, dynamic> json) {
    final dynamic data = json['data'] ?? json['user'] ?? json['message'];
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return json;
  }

  String _getUploadedImageUrl(Map<String, dynamic> json) {
    final data = _unwrap(json);
    final value =
        data['image'] ?? data['url'] ?? data['imageUrl'] ?? data['path'];

    if (value == null || value.toString().isEmpty) {
      throw Exception(
        'Could not find the uploaded image URL in the API response.',
      );
    }

    return value.toString();
  }

  @override
  Future<ResultApi<UserProfileEntity>> getUserData() async {
    try {
      final json = await _api.getUserData();
      final dto = UserProfileDto.fromJson(json);

      return Success<UserProfileEntity>(dto.toEntity());
    } catch (error) {
      return Error<UserProfileEntity>(_errorMessage(error));
    }
  }

  @override
  Future<ResultApi<UserProfileEntity>> updateUserData({
    required String name,
    required String phone,
    required String address,
    required String image,
    File? imageFile,
  }) async {
    try {
      var imageUrl = image;

      if (imageFile != null) {
        final uploadResponse = await _api.uploadImage(imageFile);
        imageUrl = _getUploadedImageUrl(uploadResponse);
      }

      final response = await _api.updateUserData(
        name: name,
        phone: phone,
        address: address,
        image: imageUrl,
      );

      final data = _unwrap(response);

      final dto = UserProfileDto.fromJson({
        'data': {
          'name': data['name'] ?? name,
          'phone': data['phone'] ?? phone,
          'address': data['address'] ?? address,
          'image': data['image'] ?? imageUrl,
        },
      });

      return Success<UserProfileEntity>(dto.toEntity());
    } catch (error) {
      return Error<UserProfileEntity>(_errorMessage(error));
    }
  }
}

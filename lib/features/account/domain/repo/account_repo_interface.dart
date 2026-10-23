import 'dart:io';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';

abstract interface class AccountRepoInterface {
  Future<ResultApi<UserProfileEntity>> getUserData();

  Future<ResultApi<UserProfileEntity>> updateUserData({
    required String name,
    required String phone,
    required String address,
    required String image,
    File? imageFile,
  });
}
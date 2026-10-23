import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_data_source_interface.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@LazySingleton(as: AccountRepoInterface)
class AccountRepoImpl implements AccountRepoInterface {
  final AccountDataSourceInterface _dataSource;

  AccountRepoImpl(this._dataSource);

  @override
  Future<ResultApi<UserProfileEntity>> getUserData() {
    return _dataSource.getUserData();
  }

  @override
  Future<ResultApi<UserProfileEntity>> updateUserData({
    required String name,
    required String phone,
    required String address,
    required String image,
    File? imageFile,
  }) {
    return _dataSource.updateUserData(
      name: name,
      phone: phone,
      address: address,
      image: image,
      imageFile: imageFile,
    );
  }
}
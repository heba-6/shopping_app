import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@injectable
class UpdateUserProfileUseCase {
  final AccountRepoInterface _repo;

  UpdateUserProfileUseCase(this._repo);

  Future<ResultApi<UserProfileEntity>> call({
    required String name,
    required String phone,
    required String address,
    required String image,
    File? imageFile,
  }) {
    return _repo.updateUserData(
      name: name,
      phone: phone,
      address: address,
      image: image,
      imageFile: imageFile,
    );
  }
}
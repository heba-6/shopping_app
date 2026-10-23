import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@injectable
class GetUserProfileUseCase {
  final AccountRepoInterface _repo;

  GetUserProfileUseCase(this._repo);

  Future<ResultApi<UserProfileEntity>> call() {
    return _repo.getUserData();
  }
}

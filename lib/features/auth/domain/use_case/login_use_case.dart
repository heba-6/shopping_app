import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

class LoginUseCase {
  final AuthRepoInterface _repo;
  LoginUseCase(this._repo);
  Future<ResultApi<LoginResponseEntity>> invoke({
    required String email,
    required String password,
  }) async => await _repo.login(email: email, password: password);
}

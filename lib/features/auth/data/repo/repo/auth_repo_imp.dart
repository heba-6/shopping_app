import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/helper/app_secure_storage.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImp implements AuthRepoInterface {
  final AuthDataSourceInterface _dataDource;
  final AppSecureStorage _storage;
  AuthRepoImp(this._dataDource, this._storage);

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _dataDource.login(email: email, password: password);
    switch (result) {
      case Success<LoginResponseEntity>():
        var entity = result.data;

        await _storage.write(AppKeys.token, entity.token);
        return Success(entity);
      case Error<LoginResponseEntity>():
        return Error(result.messageError);
    }
  }
}

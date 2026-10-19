
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/auth/data/api/auth_api.dart';
import 'package:shopping_app/features/auth/data/model/login_response_dto.dart';
import 'package:shopping_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/repo/auth_data_source_interface.dart';

@Injectable(as: AuthDataSourceInterface)
class AuthDataSourceImp implements AuthDataSourceInterface {
  final AuthApi _api;
  AuthDataSourceImp(this._api);

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _api.login(email, password);
    switch (result) {
      case Success<LoginResponseDto>():
        return Success(result.data.toEntity());
      case Error<LoginResponseDto>():
        return Error(result.messageError);
    }
  }
}

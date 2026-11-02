import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/auth/domain/entities/login_response_entity.dart';

abstract interface class AuthDataSourceInterface {
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  });
}

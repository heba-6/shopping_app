import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_keys.dart' show AppKeys;
import 'package:shopping_app/core/helper/app_secure_storage.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/core/storage/token_storage.dart';
import 'package:shopping_app/features/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._storage) : super(LoginInitial());
  final LoginUseCase _loginUseCase;
  final AppSecureStorage _storage;

  Future<void> intent(LoginIntent intent) async {
    switch (intent) {
      case LoginWithEmailPassword():
        await _login(intent.email, intent.password);
    }
  }

  Future<void> _login(String email, String password) async {
    emit(LoginLoading());
    final result = await _loginUseCase.invoke(email: email, password: password);
    switch (result) {
      case Success<LoginResponseEntity>():
        await _storage.write(AppKeys.token, result.data.token);

        await TokenStorage().saveToken(
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhYzU5MjNjYjMwZmIxZjQ3OGViYjI4YSIsImlhdCI6MTc5MTY1MTA0NSwiZXhwIjoxNzk0MjQzMDQ1fQ.j4AOpvVMlcskmgBfRNhqz2bPZRaWKYUmLtqWn6B1OK8',
        );

        emit(LoginSuccess(result.data));
      case Error<LoginResponseEntity>():
        emit(LoginError(result.messageError));
    }
  }
}

sealed class LoginIntent {}

class LoginWithEmailPassword extends LoginIntent {
  final String email;
  final String password;
  LoginWithEmailPassword(this.email, this.password);
}

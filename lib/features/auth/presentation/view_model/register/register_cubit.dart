import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/auth/data/model/register_request_model.dart';
import 'package:shopping_app/features/auth/data/repo/data_source/register_repo.dart';
import 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _repo;
  RegisterCubit(this._repo) : super(RegisterInitial());

  Future<void> register(RegisterRequestModel request) async {
    emit(RegisterLoading());
    try {
      final message = await _repo.register(request);
      emit(RegisterSuccess(message));
    } catch (e) {
      emit(RegisterError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_state.dart';

part 'home_state.dart';
part 'home_intent.dart';

@injectable
class HomeCubit extends Cubit<Homestate> {
  HomeCubit() : super(homeInitial());
  HomeCubit(this._getAllProductUseCase) : super(HomeInitial());
  final GetAllProductUseCase _getAllProductUseCase;
  Future<void> intent(HomeIntent intent) async {
    switch (intent) {
      case HProducts():
        await_getProduct();
    }
  }

  Future<void> _getProuduct() async {
    emit(HProductloading());
    final result = await _getAllProductUseCase.invoke();
    switch (result) {
      case Success<ProductResponseEntity>():
        final Listproduct = result.data.list;
        emit(HProductSuccess(Listproduct));
        throw UnimplementedError();
      case Error<ProductResponseEntity>():
        emit(HProducError(result.massageError));
    }
  }
}

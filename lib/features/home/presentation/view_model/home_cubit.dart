import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_product_use_case.dart';
// import 'package:shopping_app/features/home/presentation/view_model/home_intent.dart';

part 'home_state.dart';
part 'home_intent.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAllProductUseCase _getAllProductUseCase;

  HomeCubit(this._getAllProductUseCase) : super(HomeInitial());

  Future<void> intent(HomeIntent intent) async {
    switch (intent) {
      case HProducts():
        await _getProduct();
    }
  }

  Future<void> _getProduct() async {
    emit(HProductLoading());

    final result = await _getAllProductUseCase.invoke();
    if (isClosed) return;
    // لو الـ Cubit اتقفل أثناء تحميل البيانات
    // ما نحاولش نغيّر الـ State بعد كده
    if (isClosed) return;

    switch (result) {
      case Success<ProductResponseEntity>():
        final products = result.data.list;
        emit(HProductSuccess(products));

      case Error<ProductResponseEntity>():
        emit(HProductError(result.messageError));
    }
  }
}

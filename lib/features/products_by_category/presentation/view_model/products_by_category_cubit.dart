import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/products_by_category/domain/use_case/get_products_by_category_use_case.dart';
import 'package:shopping_app/features/products_by_category/presentation/view_model/products_by_category_state.dart';

@injectable
class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final GetProductsByCategoryUseCase _useCase;

  ProductsByCategoryCubit(this._useCase) : super(ProductsByCategoryInitial());

  Future<void> getProductsByCategory(String slug) async {
    emit(ProductsByCategoryLoading());

    try {
      final products = await _useCase.call(slug);
      emit(ProductsByCategorySuccess(products));
    } catch (e) {
      emit(ProductsByCategoryError(e.toString()));
    }
  }
}

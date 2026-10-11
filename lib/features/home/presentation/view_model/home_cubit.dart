import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_product_use_case.dart';
import 'package:shopping_app/features/home/domain/use_case/get_all_categories_use_case.dart';

part 'home_state.dart';
part 'home_intent.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAllProductUseCase _getAllProductUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  HomeCubit(this._getAllProductUseCase, this._getAllCategoriesUseCase)
    : super(const HomeState());

  Future<void> intent(HomeIntent intent) async {
    if (intent is HProducts) {
      await _getProduct();
    } else if (intent is HCategories) {
      await _getCategories();
    }
  }

  Future<void> loadHome() async {
    await Future.wait([_getProduct(), _getCategories()]);
  }

  Future<void> _getProduct() async {
    emit(state.copyWith(isProductsLoading: true, clearProductError: true));

    try {
      final result = await _getAllProductUseCase.invoke();
      if (isClosed) return;

      switch (result) {
        case Success<ProductResponseEntity>():
          emit(
            state.copyWith(
              isProductsLoading: false,
              products: result.data.list,
              clearProductError: true,
            ),
          );
        case Error<ProductResponseEntity>():
          emit(
            state.copyWith(
              isProductsLoading: false,
              productError: result.messageError,
            ),
          );
      }
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(isProductsLoading: false, productError: e.toString()),
      );
    }
  }

  Future<void> _getCategories() async {
    emit(state.copyWith(isCategoriesLoading: true, clearCategoriesError: true));

    try {
      final result = await _getAllCategoriesUseCase.invoke();
      if (isClosed) return;

      switch (result) {
        case Success<List<CategoryEntity>>():
          emit(
            state.copyWith(
              isCategoriesLoading: false,
              categories: result.data,
              clearCategoriesError: true,
            ),
          );
        case Error<List<CategoryEntity>>():
          emit(
            state.copyWith(
              isCategoriesLoading: false,
              categoriesError: result.messageError,
            ),
          );
      }
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isCategoriesLoading: false,
          categoriesError: e.toString(),
        ),
      );
    }
  }
}

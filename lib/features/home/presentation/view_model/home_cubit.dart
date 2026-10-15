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

  static const int _pageSize = 10;

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
    if (state.isProductsLoading) return;

    emit(state.copyWith(isProductsLoading: true, clearProductError: true));

    try {
      final result = await _getAllProductUseCase.invoke(
        skip: 0,
        limit: _pageSize,
      );

      if (isClosed) return;

      switch (result) {
        case Success<ProductResponseEntity>():
          final response = result.data;
          final products = response.list;

          final hasMore = response.total > 0
              ? products.length < response.total
              : products.length >= _pageSize;

          emit(
            state.copyWith(
              isProductsLoading: false,
              products: products,
              hasMoreProducts: hasMore,
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

  Future<void> loadMoreProducts() async {
    if (state.isProductsLoading ||
        state.isLoadingMore ||
        !state.hasMoreProducts ||
        state.products.isEmpty) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final result = await _getAllProductUseCase.invoke(
        skip: state.products.length,
        limit: _pageSize,
      );

      if (isClosed) return;

      switch (result) {
        case Success<ProductResponseEntity>():
          final response = result.data;
          final existingIds = state.products.map((p) => p.id).toSet();

          final newProducts = response.list
              .where((product) => !existingIds.contains(product.id))
              .toList();

          final allProducts = [...state.products, ...newProducts];

          final hasMore = response.total > 0
              ? allProducts.length < response.total
              : response.list.length >= _pageSize;

          emit(
            state.copyWith(
              isLoadingMore: false,
              products: allProducts,
              hasMoreProducts: hasMore,
              clearProductError: true,
            ),
          );

        case Error<ProductResponseEntity>():
          emit(
            state.copyWith(
              isLoadingMore: false,
              productError: result.messageError,
            ),
          );
      }
    } catch (e) {
      if (isClosed) return;

      emit(state.copyWith(isLoadingMore: false, productError: e.toString()));
    }
  }

  Future<void> _getCategories() async {
    if (state.isCategoriesLoading) return;

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

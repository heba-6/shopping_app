import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/products_by_category/domain/use_case/get_products_by_category_use_case.dart';
import 'package:shopping_app/features/products_by_category/presentation/view_model/products_by_category_state.dart';

@injectable
class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final GetProductsByCategoryUseCase _useCase;

  static const int _pageSize = 10;

  String? _currentSlug;

  ProductsByCategoryCubit(this._useCase) : super(ProductsByCategoryInitial());

  Future<void> getProductsByCategory(String slug) async {
    if (isClosed) return;

    _currentSlug = slug;

    emit(ProductsByCategoryLoading());

    try {
      final page = await _useCase.call(slug, skip: 0, limit: _pageSize);

      emit(
        ProductsByCategorySuccess(
          page.products,
          hasMoreProducts:
              page.products.isNotEmpty && page.products.length < page.total,
        ),
      );
    } catch (e) {
      emit(ProductsByCategoryError(e.toString()));
    }
  }

  Future<void> loadMoreProducts() async {
    final currentState = state;

    if (currentState is! ProductsByCategorySuccess ||
        currentState.isLoadingMore ||
        !currentState.hasMoreProducts ||
        _currentSlug == null) {
      return;
    }

    final currentProducts = currentState.products;

    emit(currentState.copyWith(isLoadingMore: true, clearLoadMoreError: true));

    try {
      final page = await _useCase.call(
        _currentSlug!,
        skip: currentProducts.length,
        limit: _pageSize,
      );

      final existingIds = currentProducts.map((p) => p.id).toSet();
      final newProducts = page.products
          .where((product) => existingIds.add(product.id))
          .toList();

      final updatedProducts = [...currentProducts, ...newProducts];

      emit(
        ProductsByCategorySuccess(
          updatedProducts,
          hasMoreProducts:
              updatedProducts.length < page.total && page.products.isNotEmpty,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          isLoadingMore: false,
          loadMoreError: e.toString(),
        ),
      );
    }
  }

  Future<void> retryLoadMore() => loadMoreProducts();
}

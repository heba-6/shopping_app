import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';

abstract class ProductsByCategoryState {}

class ProductsByCategoryInitial extends ProductsByCategoryState {}

class ProductsByCategoryLoading extends ProductsByCategoryState {}

class ProductsByCategorySuccess extends ProductsByCategoryState {
  final List<ProductByCategoryEntity> products;
  final bool isLoadingMore;
  final bool hasMoreProducts;
  final String? loadMoreError;

  ProductsByCategorySuccess(
    this.products, {
    this.isLoadingMore = false,
    this.hasMoreProducts = true,
    this.loadMoreError,
  });

  ProductsByCategorySuccess copyWith({
    List<ProductByCategoryEntity>? products,
    bool? isLoadingMore,
    bool? hasMoreProducts,
    String? loadMoreError,
    bool clearLoadMoreError = false,
  }) {
    return ProductsByCategorySuccess(
      products ?? this.products,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
      loadMoreError: clearLoadMoreError
          ? null
          : loadMoreError ?? this.loadMoreError,
    );
  }
}

class ProductsByCategoryError extends ProductsByCategoryState {
  final String message;

  ProductsByCategoryError(this.message);
}

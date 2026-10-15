part of 'home_cubit.dart';

class HomeState {
  final bool isProductsLoading;
  final bool isLoadingMore;
  final bool hasMoreProducts;
  final List<ProductItemEntity> products;
  final String? productError;

  final bool isCategoriesLoading;
  final List<CategoryEntity> categories;
  final String? categoriesError;

  const HomeState({
    this.isProductsLoading = false,
    this.isLoadingMore = false,
    this.hasMoreProducts = true,
    this.products = const [],
    this.productError,
    this.isCategoriesLoading = false,
    this.categories = const [],
    this.categoriesError,
  });

  HomeState copyWith({
    bool? isProductsLoading,
    bool? isLoadingMore,
    bool? hasMoreProducts,
    List<ProductItemEntity>? products,
    String? productError,
    bool clearProductError = false,
    bool? isCategoriesLoading,
    List<CategoryEntity>? categories,
    String? categoriesError,
    bool clearCategoriesError = false,
  }) {
    return HomeState(
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
      products: products ?? this.products,
      productError: clearProductError
          ? null
          : productError ?? this.productError,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      categories: categories ?? this.categories,
      categoriesError: clearCategoriesError
          ? null
          : categoriesError ?? this.categoriesError,
    );
  }
}

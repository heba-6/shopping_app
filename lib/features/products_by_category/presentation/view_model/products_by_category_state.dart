import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';

abstract class ProductsByCategoryState {}

class ProductsByCategoryInitial extends ProductsByCategoryState {}

class ProductsByCategoryLoading extends ProductsByCategoryState {}

class ProductsByCategorySuccess extends ProductsByCategoryState {
  final List<ProductByCategoryEntity> products;

  ProductsByCategorySuccess(this.products);
}

class ProductsByCategoryError extends ProductsByCategoryState {
  final String message;

  ProductsByCategoryError(this.message);
}

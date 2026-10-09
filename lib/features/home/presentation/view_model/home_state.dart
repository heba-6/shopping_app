part of 'home_cubit.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HProductLoading extends HomeState {}

class HProductSuccess extends HomeState {
  final List<ProductItemEntity> products;

  HProductSuccess(this.products);
}

class HProductError extends HomeState {
  final String error;

  HProductError(this.error);
}

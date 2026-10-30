import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/domain/use_case/add_to_favourite_use_case.dart';
import 'package:shopping_app/features/favourite/domain/use_case/get_favourites_use_case.dart';
import 'package:shopping_app/features/favourite/domain/use_case/remove_favourite_use_case.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_state.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';

@lazySingleton
class FavouriteCubit extends Cubit<FavouriteState> {
  final GetFavouritesUseCase _getFavouritesUseCase;
  final AddToFavouriteUseCase _addToFavouriteUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  FavouriteCubit(
    this._getFavouritesUseCase,
    this._addToFavouriteUseCase,
    this._removeFavouriteUseCase,
  ) : super(const FavouriteState());

  Future<void> getFavourites() async {
    emit(state.copyWith(status: FavouriteStatus.loading, clearError: true));

    final result = await _getFavouritesUseCase();

    if (isClosed) return;

    switch (result) {
      case Success<List<ProductsEntity>>():
        emit(
          state.copyWith(
            status: FavouriteStatus.success,
            items: result.data,
            clearError: true,
          ),
        );

      case Error<List<ProductsEntity>>():
        emit(
          state.copyWith(
            status: FavouriteStatus.failure,
            errorMessage: result.messageError,
          ),
        );
    }
  }

  Future<ResultApi<void>> toggleFavourite(ProductsEntity product) async {
    final productId = product.id;

    if (state.isProcessing(productId)) {
      return Error<void>('Please wait for the current request to finish.');
    }

    final wasFavourite = state.isFavourite(productId);

    final updatedProcessingIds = {...state.processingProductIds, productId};

    emit(
      state.copyWith(
        processingProductIds: updatedProcessingIds,
        clearError: true,
      ),
    );

    final ResultApi<void> result;

    if (wasFavourite) {
      result = await _removeFavouriteUseCase(productId: productId);
    } else {
      result = await _addToFavouriteUseCase(productId: productId);
    }

    if (isClosed) return result;

    final remainingProcessingIds = {...state.processingProductIds}
      ..remove(productId);

    switch (result) {
      case Success<void>():
        final updatedItems = [...state.items];

        if (wasFavourite) {
          updatedItems.removeWhere((item) => item.id == productId);
        } else {
          updatedItems.removeWhere((item) => item.id == productId);
          updatedItems.insert(0, product);
        }

        emit(
          state.copyWith(
            status: FavouriteStatus.success,
            items: updatedItems,
            processingProductIds: remainingProcessingIds,
            clearError: true,
          ),
        );

      case Error<void>():
        emit(
          state.copyWith(
            processingProductIds: remainingProcessingIds,
            errorMessage: result.messageError,
          ),
        );
    }

    return result;
  }

  Future<ResultApi<void>> addToFavourite(ProductsEntity product) async {
    if (state.isFavourite(product.id)) {
      return Success<void>(null);
    }

    return toggleFavourite(product);
  }

  Future<ResultApi<void>> removeFromFavourite(int productId) async {
    final product = state.items.where((item) => item.id == productId);

    if (product.isEmpty) {
      return Error<void>('Favourite item was not found.');
    }

    return toggleFavourite(product.first);
  }

  Future<ResultApi<void>> toggleCategoryFavourite(
    ProductByCategoryEntity product,
  ) {
    final favouriteProduct = ProductsEntity(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      discount: product.discountPercentage,
      rating: product.rating,
      image: product.images,
    );

    return toggleFavourite(favouriteProduct);
  }
}

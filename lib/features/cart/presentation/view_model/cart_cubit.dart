import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shopping_app/features/cart/domain/use_case/add_to_cart_use_case.dart';
import 'package:shopping_app/features/cart/domain/use_case/delete_cart_item_use_case.dart';
import 'package:shopping_app/features/cart/domain/use_case/get_cart_use_case.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  CartCubit(
    this._getCartUseCase,
    this._addToCartUseCase,
    this._deleteCartItemUseCase,
  ) : super(const CartState());

  Future<void> getCart() async {
    emit(state.copyWith(status: CartStatus.loading, clearError: true));

    final result = await _getCartUseCase();

    if (isClosed) return;

    if (result is Success<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          status: CartStatus.success,
          items: result.data,
          clearError: true,
        ),
      );
    } else if (result is Error<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: result.messageError,
        ),
      );
    }
  }

  Future<ResultApi<void>> addToCart(int productId) async {
    emit(state.copyWith(isAdding: true, clearError: true));

    try {
      final result = await _addToCartUseCase(productId: productId);

      if (isClosed) return result;

      if (result is Success<void>) {
        emit(state.copyWith(isAdding: false));

        await getCart();
      } else if (result is Error<void>) {
        emit(
          state.copyWith(isAdding: false, errorMessage: result.messageError),
        );
      }

      return result;
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(isAdding: false, errorMessage: e.toString()));
      }

      return Error<void>(e.toString());
    }
  }

  Future<ResultApi<void>> deleteCartItem(int productId) async {
    emit(state.copyWith(deletingProductId: productId, clearError: true));

    try {
      final result = await _deleteCartItemUseCase(productId: productId);

      if (isClosed) return result;

      if (result is Success<void>) {
        final updatedItems = state.items
            .where((item) => item.productId != productId)
            .toList();

        emit(
          state.copyWith(
            status: CartStatus.success,
            items: updatedItems,
            clearDeletingProductId: true,
            clearError: true,
          ),
        );
      } else if (result is Error<void>) {
        emit(
          state.copyWith(
            clearDeletingProductId: true,
            errorMessage: result.messageError,
          ),
        );
      }

      return result;
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            clearDeletingProductId: true,
            errorMessage: e.toString(),
          ),
        );
      }

      return Error<void>(e.toString());
    }
  }

  void increaseQuantity(int productId) {
    final updatedItems = state.items.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }

      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }

  void decreaseQuantity(int productId) {
    final updatedItems = state.items.map((item) {
      if (item.productId == productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }

      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }
}

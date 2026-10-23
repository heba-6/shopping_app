import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';

enum CartStatus { initial, loading, success, failure }

class CartState {
  final CartStatus status;
  final List<CartItemEntity> items;
  final String? errorMessage;
  final bool isAdding;
  final int? deletingProductId;

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.errorMessage,
    this.isAdding = false,
    this.deletingProductId,
  });

  double get subtotal {
    return items.fold<double>(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalQuantity {
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  CartState copyWith({
    CartStatus? status,
    List<CartItemEntity>? items,
    String? errorMessage,
    bool clearError = false,
    bool? isAdding,
    int? deletingProductId,
    bool clearDeletingProductId = false,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isAdding: isAdding ?? this.isAdding,
      deletingProductId: clearDeletingProductId
          ? null
          : deletingProductId ?? this.deletingProductId,
    );
  }
}

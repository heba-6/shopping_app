class CartItemEntity {
  final int productId;
  final String title;
  final String image;
  final double price;
  final int quantity;

  const CartItemEntity({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  CartItemEntity copyWith({
    int? productId,
    String? title,
    String? image,
    double? price,
    int? quantity,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

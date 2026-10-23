import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';

class CartDto {
  final int productId;
  final String title;
  final String image;
  final double price;
  final int quantity;

  const CartDto({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) {
    final productValue = json['product'];

    final Map<String, dynamic> product = productValue is Map
        ? Map<String, dynamic>.from(productValue)
        : json;

    return CartDto(
      productId: _toInt(
        json['productId'] ?? json['product_id'] ?? product['id'] ?? json['id'],
      ),
      title: _toString(
        product['title'] ?? product['name'] ?? json['title'] ?? json['name'],
        fallback: 'Product',
      ),
      image: _toImage(
        product['image'] ??
            product['images'] ??
            product['thumbnail'] ??
            json['image'] ??
            json['images'],
      ),
      price: _toDouble(product['price'] ?? json['price']),
      quantity: _toInt(json['quantity'] ?? json['count'], fallback: 1),
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      title: title,
      image: image,
      price: price,
      quantity: quantity < 1 ? 1 : quantity,
    );
  }

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is num) return value.toInt();

    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();

    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }

  static String _toString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;

    final result = value.toString().trim();

    return result.isEmpty ? fallback : result;
  }

  static String _toImage(dynamic value) {
    if (value is String) return value;

    if (value is List && value.isNotEmpty) {
      return value.first?.toString() ?? '';
    }

    return '';
  }
}

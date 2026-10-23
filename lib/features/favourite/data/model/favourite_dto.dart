import 'package:shopping_app/core/model/item/product_item_entity.dart';

class FavouriteDto {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discount;
  final double rating;
  final List<String> images;

  const FavouriteDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.rating,
    required this.images,
  });

  factory FavouriteDto.fromJson(Map<String, dynamic> json) {
    final product = json['product'] is Map
        ? Map<String, dynamic>.from(json['product'] as Map)
        : json;

    final rawImages =
        product['images'] ?? product['image'] ?? product['thumbnail'];

    final List<String> images;

    if (rawImages is List) {
      images = rawImages
          .where((item) => item != null && item.toString().isNotEmpty)
          .map((item) => item.toString())
          .toList();
    } else if (rawImages is String && rawImages.isNotEmpty) {
      images = [rawImages];
    } else {
      images = [];
    }

    return FavouriteDto(
      id:
          int.tryParse(
            (product['id'] ?? product['productId'] ?? json['productId'])
                .toString(),
          ) ??
          0,
      title: (product['title'] ?? product['name'] ?? '').toString(),
      description: (product['description'] ?? '').toString(),
      price: _toDouble(product['price']),
      discount: _toDouble(product['discount'] ?? product['discountPercentage']),
      rating: _toDouble(product['rating']),
      images: images,
    );
  }

  ProductsEntity toEntity() {
    return ProductsEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      discount: discount,
      rating: rating,
      image: images,
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }
}

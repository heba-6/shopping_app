import '../../domain/entities/product_by_category_entity.dart';

class ProductByCategoryDto {
  final int id;
  final String title;
  final String image;
  final double price;
  final double discount;

  const ProductByCategoryDto({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.discount,
  });

  factory ProductByCategoryDto.fromJson(Map<String, dynamic> json) {
    return ProductByCategoryDto(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
    );
  }

  ProductByCategoryEntity toEntity() {
    return ProductByCategoryEntity(
      id: id,
      title: title,
      image: image,
      price: price,
      discount: discount,
    );
  }
}

import 'review_model.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<String> images;
  final List<ReviewModel> reviews;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.images,
    this.reviews = const [],
  });

  double get finalPrice => price * (1 - discountPercentage / 100);
  bool get hasDiscount => discountPercentage > 0;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      images:
          (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      reviews: (json['reviews'] as List? ?? [])
          .map((e) => ReviewModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

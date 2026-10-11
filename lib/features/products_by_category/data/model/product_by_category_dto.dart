class ProductByCategoryDto {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<String> images;

  const ProductByCategoryDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.images,
  });

  factory ProductByCategoryDto.fromJson(Map<String, dynamic> json) {
    return ProductByCategoryDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      images:
          (json['images'] as List?)
              ?.map((image) => image.toString())
              .toList() ??
          [],
    );
  }
}

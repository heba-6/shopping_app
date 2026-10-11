import 'product_by_category_dto.dart';

class ProductsByCategoryResponseDto {
  final List<ProductByCategoryDto> list;
  final int total;
  final int skip;
  final int limit;

  const ProductsByCategoryResponseDto({
    required this.list,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsByCategoryResponseDto.fromJson(Map<String, dynamic> json) {
    final productsJson = json['list'] as List? ?? [];

    return ProductsByCategoryResponseDto(
      list: productsJson
          .map(
            (item) => ProductByCategoryDto.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
      total: (json['total'] as num?)?.toInt() ?? 0,
      skip: (json['skip'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
    );
  }
}

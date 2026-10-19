import 'search_product_dto.dart';

class SearchResponseDto {
  final List<SearchProductDto> list;
  final int total;
  final int skip;
  final int limit;

  const SearchResponseDto({
    required this.list,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory SearchResponseDto.fromJson(Map<String, dynamic> json) {
    final productsJson = json['list'] as List? ?? [];

    return SearchResponseDto(
      list: productsJson
          .map(
            (item) => SearchProductDto.fromJson(
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

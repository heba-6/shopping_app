import 'search_product_entity.dart';

class SearchPageEntity {
  final List<SearchProductEntity> products;
  final int total;
  final int skip;
  final int limit;

  const SearchPageEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}

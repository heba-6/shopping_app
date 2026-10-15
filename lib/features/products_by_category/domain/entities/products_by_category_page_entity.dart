import 'product_by_category_entity.dart';

class ProductsByCategoryPageEntity {
  final List<ProductByCategoryEntity> products;
  final int total;
  final int skip;
  final int limit;

  const ProductsByCategoryPageEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}

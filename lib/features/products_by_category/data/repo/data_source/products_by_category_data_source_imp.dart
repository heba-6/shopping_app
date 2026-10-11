import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/products_by_category/data/api/products_by_category_api.dart';
import 'package:shopping_app/features/products_by_category/data/model/products_by_category_response_dto.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_data_source_interface.dart';

@LazySingleton(as: ProductsByCategoryDataSourceInterface)
class ProductsByCategoryDataSourceImpl
    implements ProductsByCategoryDataSourceInterface {
  final ProductsByCategoryApi _api;

  ProductsByCategoryDataSourceImpl(this._api);

  @override
  Future<ResultApi<List<ProductByCategoryEntity>>> getProductsByCategory(
    String slug,
  ) async {
    try {
      final json = await _api.getProductsByCategory(slug);

      final responseDto = ProductsByCategoryResponseDto.fromJson(json);

      final products = responseDto.list.map((product) {
        return ProductByCategoryEntity(
          id: product.id,
          title: product.title,
          description: product.description,
          price: product.price,
          discountPercentage: product.discountPercentage,
          rating: product.rating,
          images: product.images,
        );
      }).toList();

      return Success<List<ProductByCategoryEntity>>(products);
    } catch (e) {
      return Error<List<ProductByCategoryEntity>>(e.toString());
    }
  }
}

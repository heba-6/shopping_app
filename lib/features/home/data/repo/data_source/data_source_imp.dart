import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/data/api/api.dart';
import 'package:shopping_app/features/home/data/model/product_response_dto.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';

@LazySingleton(as: HomeDataSourceInterface)
class HomeDataSourceImpl implements HomeDataSourceInterface {
  final Api _api;

  HomeDataSourceImpl(this._api);

  @override
  Future<ResultApi<ProductResponseEntity>> getallproduct() async {
    try {
      final json = await _api.getAllProducts();
      final dto = ProductResponseDto.fromJson(json);

      final products = (dto.list ?? []).map((item) {
        return ProductItemEntity(
          id: item.id ?? 0,
          title: item.title ?? '',
          description: item.description ?? '',
          price: item.price ?? 0.0,
          discountPercentage: item.discountPercentage ?? 0.0,
          rating: item.rating ?? 0.0,
          images: item.images ?? [],
        );
      }).toList();

      return Success<ProductResponseEntity>(
        ProductResponseEntity(
          list: products,
          total: dto.total ?? 0,
          skip: dto.skip ?? 0,
          limit: dto.limit ?? 0,
        ),
      );
    } catch (e) {
      return Error<ProductResponseEntity>('Failed to load products: $e');
    }
  }
}

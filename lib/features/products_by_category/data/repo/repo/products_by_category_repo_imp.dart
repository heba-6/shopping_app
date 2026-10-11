import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_data_source_interface.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_repo_interface.dart';

@LazySingleton(as: ProductsByCategoryRepoInterface)
class ProductsByCategoryRepoImpl implements ProductsByCategoryRepoInterface {
  final ProductsByCategoryDataSourceInterface _dataSource;

  ProductsByCategoryRepoImpl(this._dataSource);

  @override
  Future<List<ProductByCategoryEntity>> getProductsByCategory(
    String slug,
  ) async {
    final result = await _dataSource.getProductsByCategory(slug);

    if (result is Success<List<ProductByCategoryEntity>>) {
      return result.data;
    }

    if (result is Error<List<ProductByCategoryEntity>>) {
      throw Exception(result.messageError);
    }

    throw Exception('Unexpected result from data source');
  }
}

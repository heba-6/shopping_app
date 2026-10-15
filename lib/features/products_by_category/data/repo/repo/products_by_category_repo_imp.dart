import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/products_by_category_page_entity.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_data_source_interface.dart';
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_repo_interface.dart';

@LazySingleton(as: ProductsByCategoryRepoInterface)
class ProductsByCategoryRepoImpl implements ProductsByCategoryRepoInterface {
  final ProductsByCategoryDataSourceInterface _dataSource;

  ProductsByCategoryRepoImpl(this._dataSource);

  @override
  Future<ProductsByCategoryPageEntity> getProductsByCategory(
    String slug, {
    required int skip,
    int limit = 10,
  }) async {
    final result = await _dataSource.getProductsByCategory(
      slug,
      skip: skip,
      limit: limit,
    );

    if (result is Success<ProductsByCategoryPageEntity>) {
      return result.data;
    }

    if (result is Error<ProductsByCategoryPageEntity>) {
      throw Exception(result.messageError);
    }

    throw Exception('Unexpected result from data source');
  }
}

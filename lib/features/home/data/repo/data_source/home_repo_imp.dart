import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@Injectable(as: HomeRepoInterface)
class HomeRepoImpl implements HomeRepoInterface {
  final HomeDataSourceInterface _homeDataSource;

  HomeRepoImpl(this._homeDataSource);

  @override
  Future<ResultApi<ProductResponseEntity>> getallproduct({
    required int skip,
    int limit = 10,
  }) {
    return _homeDataSource.getallproduct(skip: skip, limit: limit);
  }

  @override
  Future<ResultApi<List<CategoryEntity>>> getAllCategories() {
    return _homeDataSource.getAllCategories();
  }
}

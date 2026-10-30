import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';

@LazySingleton(as: FavouriteRepoInterface)
class FavouriteRepoImp implements FavouriteRepoInterface {
  final FavouriteDataSourceInterface _dataSource;

  FavouriteRepoImp(this._dataSource);

  @override
  Future<ResultApi<List<ProductsEntity>>> getFavourites() {
    return _dataSource.getFavourites();
  }

  @override
  Future<ResultApi<void>> addToFavourite({required int productId}) {
    return _dataSource.addToFavourite(productId: productId);
  }

  @override
  Future<ResultApi<void>> removeFromFavourite({required int productId}) {
    return _dataSource.removeFromFavourite(productId: productId);
  }
}

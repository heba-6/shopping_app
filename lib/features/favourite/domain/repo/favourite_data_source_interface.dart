import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/networking/result_api.dart';

abstract class FavouriteDataSourceInterface {
  Future<ResultApi<List<ProductsEntity>>> getFavourites();

  Future<ResultApi<void>> addToFavourite({required int productId});

  Future<ResultApi<void>> removeFromFavourite({required int productId});
}

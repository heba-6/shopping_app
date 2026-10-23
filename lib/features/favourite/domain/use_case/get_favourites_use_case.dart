import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';

@injectable
class GetFavouritesUseCase {
  final FavouriteRepoInterface _repo;

  GetFavouritesUseCase(this._repo);

  Future<ResultApi<List<ProductsEntity>>> call() {
    return _repo.getFavourites();
  }
}

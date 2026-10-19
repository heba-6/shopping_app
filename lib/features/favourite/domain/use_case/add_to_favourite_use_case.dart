import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo_interface.dart';

@injectable
class AddToFavouriteUseCase {
  final FavouriteRepoInterface _repo;

  AddToFavouriteUseCase(this._repo);

  Future<ResultApi<void>> call({required int productId}) {
    return _repo.addToFavourite(productId: productId);
  }
}

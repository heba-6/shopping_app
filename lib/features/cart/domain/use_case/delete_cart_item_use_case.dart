import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';

@injectable
class DeleteCartItemUseCase {
  final CartRepoInterface _repo;

  DeleteCartItemUseCase(this._repo);

  Future<ResultApi<void>> call({required int productId}) {
    return _repo.deleteCartItem(productId: productId);
  }
}

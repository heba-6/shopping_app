import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';

@injectable
class GetCartUseCase {
  final CartRepoInterface _repo;

  GetCartUseCase(this._repo);

  Future<ResultApi<List<CartItemEntity>>> call() {
    return _repo.getCart();
  }
}

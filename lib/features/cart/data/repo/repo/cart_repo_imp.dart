import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/data/model/cart_dto.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';

@Injectable(as: CartRepoInterface)
class CartRepoImp implements CartRepoInterface {
  final CartDataSourceInterface _dataSource;

  CartRepoImp(this._dataSource);

  @override
  Future<ResultApi<List<CartItemEntity>>> getCart() async {
    final result = await _dataSource.getCart();

    switch (result) {
      case Success<List<CartDto>>():
        return Success(result.data.map((item) => item.toEntity()).toList());
      case Error<List<CartDto>>():
        return Error(result.messageError);
    }
  }

  @override
  Future<ResultApi<void>> addToCart({required int productId}) async {
    return _dataSource.addToCart(productId: productId);
  }

  @override
  Future<ResultApi<void>> deleteCartItem({required int productId}) async {
    return _dataSource.deleteCartItem(productId: productId);
  }
}

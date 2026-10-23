import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/features/cart/domain/repo/cart_repo_interface.dart';

@LazySingleton(as: CartRepoInterface)
class CartRepoImp implements CartRepoInterface {
  final CartDataSourceInterface _dataSource;

  CartRepoImp(this._dataSource);

  @override
  Future<ResultApi<List<CartItemEntity>>> getCart() {
    return _dataSource.getCart();
  }

  @override
  Future<ResultApi<void>> addToCart({
    required int productId,
  }) {
    return _dataSource.addToCart(
      productId: productId,
    );
  }

  @override
  Future<ResultApi<void>> deleteCartItem({
    required int productId,
  }) {
    return _dataSource.deleteCartItem(
      productId: productId,
    );
  }
}
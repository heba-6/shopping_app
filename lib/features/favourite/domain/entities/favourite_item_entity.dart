import 'package:shopping_app/core/model/item/product_item_entity.dart';

class FavouriteItemEntity {
  final ProductsEntity product;

  const FavouriteItemEntity({required this.product});

  int get id => product.id;
  String get title => product.title;
  double get price => product.price;
  List<String> get image => product.image;
}

import 'package:shopping_app/core/model/item/product_item_entity.dart';

class ProductItemDto extends ProductItemEntity {
  ProductItemDto({super.list, super.total, super.skip, super.limit});

  ProductItemDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ProductsDto>[];
      json['list'].forEach((v) {
        list!.add(ProductsDto.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

class ProductsDto extends ProductsEntity {
  ProductsDto({
    super.id,
    super.title,
    super.description,
    super.price,
    super.discount,
    super.rating,
    super.image,
  });
  ProductsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['images'];
  }
}

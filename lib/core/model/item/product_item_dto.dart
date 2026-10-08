class ProductItemDto {
  List<ProductsDto>? list;
  int? total;
  int? skip;
  int? limit;

  ProductItemDto({this.list, this.total, this.skip, this.limit});

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

class ProductsDto {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;

  List<String>? images;

  ProductsDto({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
  });
  ProductsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = price = (json['price'] as num?)?.toDouble();

    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    rating = (json['rating'] as num?)?.toDouble();
    images = (json['images'] as List?)
        ?.map((image) => image.toString())
        .toList();
  }
}

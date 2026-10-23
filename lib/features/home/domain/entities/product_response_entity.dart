class ProductResponseEntity {
  List<ProductItemEntity> list;
  int total;
  int skip;
  int limit;

  ProductResponseEntity({
    this.list = const [],
    this.total = 0,
    this.skip = 0,
    this.limit = 0,
  });
}

class ProductItemEntity {
  int id;
  String title;
  String description;
  double price;
  double discountPercentage;
  double rating;
  List<String> images;

  ProductItemEntity({
    this.id = 0,
    this.title = "title",
    this.description = "",
    this.price = 10.0,
    this.discountPercentage = 7.0,
    this.rating = 5.0,
    this.images = const [],
  });
}

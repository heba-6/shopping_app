class ProductItemEntity {
  List<ProductsEntity>? list;
  int total;
  int skip;
  int limit;

  ProductItemEntity({
    this.list = const [],
    this.total = 0,
    this.skip = 0,
    this.limit = 10,
  });
}

class ProductsEntity {
  int id;
  String title;
  String description;
  double price;
  double discount;
  double rating;

  List<String> image;

  ProductsEntity({
    this.id = 0,
    this.title = "title",
    this.description = "description",
    this.price = 10,
    this.discount = 7,
    this.rating = 5.0,
    this.image = const [],
  });
}

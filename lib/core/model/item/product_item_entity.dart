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
  String category;
  double price;
  double discountPercentage;
  double rating;

  List<String>? images;

  ProductsEntity({
    this.id = 0,
    this.title = "title",
    this.description = "description",
    this.category = "category",
    this.price = 10,
    this.discountPercentage = 7,
    this.rating = 5.0,
    this.images = const [],
  });
}

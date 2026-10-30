class ProductResponseDto {
  List<ProductItemDto>? list;
  int? total;
  int? skip;
  int? limit;

  ProductResponseDto({this.list, this.total, this.skip, this.limit});

  ProductResponseDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ProductItemDto>[];

      json['list'].forEach((v) {
        list!.add(ProductItemDto.fromJson(v));
      });
    }

    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list?.map((v) => v.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}

class ProductItemDto {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  List<String>? images;

  ProductItemDto({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
  });

  ProductItemDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];

    price = (json['price'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    rating = (json['rating'] as num?)?.toDouble();

    images = (json['images'] as List?)?.map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'images': images,
    };
  }
}

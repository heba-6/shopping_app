class CategoryResponseDto {
  final List<CategoryDto>? list;

  const CategoryResponseDto({this.list});

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) {
    return CategoryResponseDto(
      list: (json['list'] as List<dynamic>?)
          ?.map((item) => CategoryDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CategoryDto {
  final String? slug;
  final String? name;
  final String? url;
  final String? image;

  const CategoryDto({this.slug, this.name, this.url, this.image});

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      slug: json['slug'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
    );
  }
}

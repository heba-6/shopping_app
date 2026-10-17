import 'package:injectable/injectable.dart';

import '../../../domain/entities/search_page_entity.dart';
import '../../../domain/repo/search_data_source_interface.dart';
import '../../api/search_api.dart';
import '../../model/search_response_dto.dart';
import '../../../domain/entities/search_product_entity.dart';

@LazySingleton(as: SearchDataSourceInterface)
class SearchDataSourceImp implements SearchDataSourceInterface {
  final SearchApi _searchApi;

  SearchDataSourceImp(this._searchApi);

  @override
  Future<SearchPageEntity> searchProducts(String query) async {
    final response = await _searchApi.searchProducts(query);
    final searchResponse = SearchResponseDto.fromJson(response);

    return SearchPageEntity(
      products: searchResponse.list
          .map(
            (product) => SearchProductEntity(
              id: product.id,
              title: product.title,
              description: product.description,
              price: product.price,
              discountPercentage: product.discountPercentage,
              rating: product.rating,
              images: product.images,
            ),
          )
          .toList(),
      total: searchResponse.total,
      skip: searchResponse.skip,
      limit: searchResponse.limit,
    );
  }
}

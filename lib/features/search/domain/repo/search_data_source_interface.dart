import '../entities/search_page_entity.dart';

abstract class SearchDataSourceInterface {
  Future<SearchPageEntity> searchProducts(String query);
}

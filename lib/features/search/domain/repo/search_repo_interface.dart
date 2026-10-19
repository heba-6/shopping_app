import '../entities/search_page_entity.dart';

abstract class SearchRepoInterface {
  Future<SearchPageEntity> searchProducts(String query);
}

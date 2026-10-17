import 'package:injectable/injectable.dart';

import '../entities/search_page_entity.dart';
import '../repo/search_repo_interface.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepoInterface _searchRepo;

  SearchProductsUseCase(this._searchRepo);

  Future<SearchPageEntity> call(String query) {
    return _searchRepo.searchProducts(query);
  }
}

import 'package:injectable/injectable.dart';

import '../../../domain/entities/search_page_entity.dart';
import '../../../domain/repo/search_data_source_interface.dart';
import '../../../domain/repo/search_repo_interface.dart';

@LazySingleton(as: SearchRepoInterface)
class SearchRepoImp implements SearchRepoInterface {
  final SearchDataSourceInterface _searchDataSource;

  SearchRepoImp(this._searchDataSource);

  @override
  Future<SearchPageEntity> searchProducts(String query) {
    return _searchDataSource.searchProducts(query);
  }
}

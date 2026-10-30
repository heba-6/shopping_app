import 'package:shopping_app/features/search/domain/entities/search_page_entity.dart';

sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchPageEntity searchPage;

  SearchSuccess(this.searchPage);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}

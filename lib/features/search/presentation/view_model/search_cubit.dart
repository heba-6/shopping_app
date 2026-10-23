import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/search_page_entity.dart';
import '../../domain/use_case/search_products_use_case.dart';
import 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;

  Timer? _debounce;
  int _requestId = 0;

  SearchCubit(this._searchProductsUseCase) : super(SearchInitial());

  void searchProducts(String query) {
    _debounce?.cancel();

    final currentRequestId = ++_requestId;
    final searchQuery = query.trim();

    if (searchQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(searchQuery, currentRequestId);
    });
  }

  Future<void> _performSearch(String query, int requestId) async {
    emit(SearchLoading());

    try {
      debugPrint('Searching for: $query');

      final result = await _searchProductsUseCase.call(query);

      // Ignore results from older requests.
      if (isClosed || requestId != _requestId) return;

      final normalizedQuery = query.toLowerCase();

      final filteredProducts = result.products.where((product) {
        return product.title.toLowerCase().contains(normalizedQuery) ||
            product.description.toLowerCase().contains(normalizedQuery);
      }).toList();

      debugPrint('Products from API: ${result.products.length}');
      debugPrint('Products after filtering: ${filteredProducts.length}');

      if (filteredProducts.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(
          SearchSuccess(
            SearchPageEntity(
              products: filteredProducts,
              total: filteredProducts.length,
              skip: result.skip,
              limit: result.limit,
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      if (isClosed || requestId != _requestId) return;

      debugPrint('Search error: $e');
      debugPrint('$stackTrace');

      emit(SearchError('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

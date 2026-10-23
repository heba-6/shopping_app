import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/custom_text_field.dart';

import '../../view_model/search_cubit.dart';
import '../../view_model/search_state.dart';
import '../widgets/search_results.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextFormField(
              controller: _searchController,
              hintText: 'Search Your for products...',
              prefixIcon: const Icon(Icons.search),
              keyboardType: TextInputType.text,
              action: TextInputAction.search,

              onChanged: (value) {
                debugPrint('Search input: $value');
                context.read<SearchCubit>().searchProducts(value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(
                      child: Text('Search for your favorite products'),
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchEmpty) {
                    return const Center(child: Text('No products found'));
                  }

                  if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is SearchSuccess) {
                    return SearchResults(products: state.searchPage.products);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

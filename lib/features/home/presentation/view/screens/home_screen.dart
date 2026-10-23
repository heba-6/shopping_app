import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_assets/app_asset_image.dart';

import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/core/widgets/shared_item_widget.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:shopping_app/features/products_by_category/presentation/view/screens/products_by_category_screen.dart';
import 'package:shopping_app/features/search/presentation/view/screens/search_screen.dart';
import 'package:shopping_app/features/search/presentation/view_model/search_cubit.dart';
import 'package:shopping_app/core/di/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  String? selectedSlug;

  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.extentAfter < 300) {
      context.read<HomeCubit>().loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, elevation: 0),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: TextField(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => serviceLocator<SearchCubit>(),
                          child: const SearchScreen(),
                        ),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for products...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFD1D5DB),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (state.isCategoriesLoading && state.categories.isEmpty)
                const CategoriesSkeleton()
              else if (state.categoriesError != null &&
                  state.categories.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Failed to load categories: '
                    '${state.categoriesError}',
                  ),
                )
              else
                CategoriesWidget(
                  categories: state.categories,
                  selectedSlug: selectedSlug,
                  onCategoryTap: (CategoryEntity category) {
                    setState(() {
                      selectedSlug = category.slug;
                    });

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductsByCategoryScreen(
                          slug: category.slug,
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 12),

              if (state.isProductsLoading && state.products.isEmpty)
                const Expanded(child: ProductsSkeleton())
              else if (state.productError != null && state.products.isEmpty)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Failed to load products: '
                        '${state.productError}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              else if (state.products.isEmpty)
                const Expanded(
                  child: Center(child: Text('No products available')),
                )
              else
                Expanded(
                  child: GridView.builder(
                    key: const PageStorageKey<String>('home_products_grid'),
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        state.products.length + (state.isLoadingMore ? 2 : 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 18,
                          childAspectRatio: 163 / 288,
                        ),
                    itemBuilder: (context, index) {
                      if (index >= state.products.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final apiProduct = state.products[index];

                      final product = ProductsEntity(
                        id: apiProduct.id,
                        title: apiProduct.title,
                        description: apiProduct.description,
                        price: apiProduct.price,
                        discount: apiProduct.discountPercentage,
                        rating: apiProduct.rating,
                        image: apiProduct.images,
                      );

                      return SharedItemWidget(
                        product: product,
                        onTap: () {},
                        favoriteOnTap: () {},
                        addToCartOnTap: () {},
                      );
                    },
                  ),
                ),

              if (state.productError != null && state.products.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Could not load more products.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: state.isLoadingMore
                            ? null
                            : () {
                                context.read<HomeCubit>().loadMoreProducts();
                              },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final Product = ProductsEntity(
      id: 1,
      title: "title",
      description: "This is a detailed description of the product.",
      price: 150,
      discount: 12.5,
      rating: 4.7,
      image: [AssetsImages.onboarding_1],
    );
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 18,
        childAspectRatio: 163 / 288,
      ),
      itemBuilder: (context, index) => ProductItemCard(
        product: Product,
        onTap: () {},
        favoriteOnTap: () {},
        addToCartOnTap: () {},
      ),
    );
  }
}

class ProductsSkeleton extends StatelessWidget {
  const ProductsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 18,
        childAspectRatio: 163 / 288,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/helper/cart_helper.dart';
import 'package:shopping_app/core/helper/favourite_helper.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/widgets/shared_item_widget.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_state.dart';

import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/home_skeletons.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/category_banner_slider.dart';

import 'package:shopping_app/features/products_by_category/presentation/view/screens/products_by_category_screen.dart';
import 'package:shopping_app/features/search/presentation/view/screens/search_screen.dart';
import 'package:shopping_app/features/search/presentation/view_model/search_cubit.dart';

class HomeScreen extends StatefulWidget {
  final bool isActive;

  const HomeScreen({super.key, this.isActive = true});

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

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, elevation: 0),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HomeHeader(),

              const SizedBox(height: 12),

              if (state.isCategoriesLoading && state.categories.isEmpty)
                const HomeCategoriesSkeleton()
              else if (state.categoriesError != null &&
                  state.categories.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Failed to load categories: '
                    '${state.categoriesError}',
                    style: theme.textTheme.bodyMedium,
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

              Expanded(
                child: CustomScrollView(
                  key: const PageStorageKey<String>('home_products_scroll'),
                  controller: _scrollController,
                  slivers: [
                    if (state.categories.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CategoryBannerSlider(
                            categories: state.categories,
                            isActive: widget.isActive,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 12)),
                    ] else if (state.isCategoriesLoading) ...[
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: HomeBannerSkeleton(),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 12)),
                    ],

                    if (state.isProductsLoading && state.products.isEmpty)
                      const HomeProductsSkeleton()
                    else if (state.productError != null &&
                        state.products.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Failed to load products: '
                              '${state.productError}',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      )
                    else if (state.products.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'No products available',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index >= state.products.length) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryOrange,
                                  ),
                                );
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
                                favoriteOnTap: () {
                                  FavouriteHelper.toggleFavourite(
                                    context,
                                    product,
                                  );
                                },
                                addToCartOnTap: () {
                                  CartHelper.addToCart(context, product.id);
                                },
                              );
                            },
                            childCount:
                                state.products.length +
                                (state.isLoadingMore ? 2 : 0),
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 18,
                                childAspectRatio: 163 / 288,
                              ),
                        ),
                      ),

                    if (state.productError != null && state.products.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Could not load more products.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: state.isLoadingMore
                                    ? null
                                    : () {
                                        context
                                            .read<HomeCubit>()
                                            .loadMoreProducts();
                                      },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
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

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, accountState) {
          final fullName = accountState.profile?.name.trim() ?? '';
          final firstName = fullName.isEmpty
              ? 'there'
              : fullName.split(RegExp(r'\s+|(?=[A-Z])')).first;

          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi $firstName!',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Let’s start your day',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
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
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(Icons.search_rounded, size: 26),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/helper/cart_helper.dart';
import 'package:shopping_app/core/helper/favourite_helper.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/widgets/shared_item_widget.dart';
import 'package:shopping_app/features/products_by_category/presentation/view_model/products_by_category_cubit.dart';
import 'package:shopping_app/features/products_by_category/presentation/view_model/products_by_category_state.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String slug;
  final String categoryName;

  const ProductsByCategoryScreen({
    super.key,
    required this.slug,
    required this.categoryName,
  });

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen>
    with AutomaticKeepAliveClientMixin {
  late final ProductsByCategoryCubit _cubit;
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _cubit = serviceLocator<ProductsByCategoryCubit>();
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);

    _cubit.getProductsByCategory(widget.slug);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.extentAfter < 300) {
      _cubit.loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.categoryName)),
        body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
          builder: (context, state) {
            if (state is ProductsByCategoryInitial ||
                state is ProductsByCategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              );
            }

            if (state is ProductsByCategoryError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductsByCategoryCubit>()
                            .getProductsByCategory(widget.slug);
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }

            if (state is ProductsByCategorySuccess) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text(
                    'No products found in this category',
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }

              return GridView.builder(
                key: PageStorageKey<String>('products-${widget.slug}'),
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 163 / 288,
                ),
                itemCount:
                    state.products.length +
                    (state.isLoadingMore || state.loadMoreError != null
                        ? 1
                        : 0),
                itemBuilder: (context, index) {
                  if (index >= state.products.length) {
                    if (state.loadMoreError != null) {
                      return Center(
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<ProductsByCategoryCubit>()
                                .retryLoadMore();
                          },
                          child: const Text('Retry loading more'),
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryOrange,
                      ),
                    );
                  }

                  final product = state.products[index];

                  final sharedProduct = ProductsEntity(
                    id: product.id,
                    title: product.title,
                    description: product.description,
                    price: product.price,
                    discount: product.discountPercentage,
                    rating: product.rating,
                    image: product.images,
                  );

                  return SharedItemWidget(
                    product: sharedProduct,
                    onTap: () {},
                    favoriteOnTap: () {
                      FavouriteHelper.toggleCategoryFavourite(context, product);
                    },
                    addToCartOnTap: () {
                      CartHelper.addToCart(context, product.id);
                    },
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

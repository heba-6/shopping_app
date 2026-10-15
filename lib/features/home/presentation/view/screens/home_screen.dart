import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/shared_item_widget.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:shopping_app/features/products_by_category/presentation/view/screens/products_by_category_screen.dart';

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
      appBar: AppBar(title: const Text('Shopping App'), centerTitle: false),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return const SkeletonBox(width: 90, height: 40, radius: 20);
        },
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
        return const ProductSkeletonCard();
      },
    );
  }
}

class ProductSkeletonCard extends StatelessWidget {
  const ProductSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 6,
          child: SkeletonBox(width: double.infinity, radius: 12),
        ),
        const SizedBox(height: 10),
        const SkeletonBox(width: 110, height: 14, radius: 4),
        const SizedBox(height: 8),
        const SkeletonBox(width: 70, height: 12, radius: 4),
        const SizedBox(height: 8),
        const SkeletonBox(width: 85, height: 16, radius: 4),
        const SizedBox(height: 10),
        const SkeletonBox(width: double.infinity, height: 34, radius: 8),
      ],
    );
  }
}

class SkeletonBox extends StatefulWidget {
  final double width;
  final double? height;
  final double radius;

  const SkeletonBox({
    super.key,
    required this.width,
    this.height,
    this.radius = 8,
  });

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.lerp(
              const Color(0xFFE5E7EB),
              const Color(0xFFF5F5F5),
              _controller.value,
            ),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        );
      },
    );
  }
}

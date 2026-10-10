import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/categories_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedSlug;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<HomeCubit>().loadHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping App'), centerTitle: false),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Categories section
              if (state.isCategoriesLoading)
                const SizedBox(
                  height: 48,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.categoriesError != null)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Failed to load categories: ${state.categoriesError}',
                  ),
                )
              else
                CategoriesWidget(
                  categories: state.categories,
                  selectedSlug: selectedSlug,
                  onCategoryTap: (slug) {
                    setState(() {
                      selectedSlug = slug;
                    });
                  },
                ),

              const SizedBox(height: 12),

              // Products section
              if (state.isProductsLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.productError != null)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Failed to load products: ${state.productError}',
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
                    padding: const EdgeInsets.all(16),
                    itemCount: state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 18,
                          childAspectRatio: 163 / 288,
                        ),
                    itemBuilder: (context, index) {
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

                      return ProductItemCard(
                        product: product,
                        onTap: () {},
                        favoriteOnTap: () {},
                        addToCartOnTap: () {},
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

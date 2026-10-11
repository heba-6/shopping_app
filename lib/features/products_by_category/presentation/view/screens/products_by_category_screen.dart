import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/features/products_by_category/presentation/view_model/products_by_category_cubit.dart';
import 'package:shopping_app/features/products_by_category/presentation/view_model/products_by_category_state.dart';

import 'package:shopping_app/core/widgets/shared_item_widget.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String slug;
  final String categoryName;

  const ProductsByCategoryScreen({
    super.key,
    required this.slug,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<ProductsByCategoryCubit>()
            ..getProductsByCategory(slug),
      child: Scaffold(
        appBar: AppBar(title: Text(categoryName)),
        body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
          builder: (context, state) {
            if (state is ProductsByCategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductsByCategoryError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductsByCategoryCubit>()
                            .getProductsByCategory(slug);
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }

            if (state is ProductsByCategorySuccess) {
              if (state.products.isEmpty) {
                return const Center(
                  child: Text('No products found in this category'),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 163 / 288,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
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
                    favoriteOnTap: () {},
                    addToCartOnTap: () {},
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

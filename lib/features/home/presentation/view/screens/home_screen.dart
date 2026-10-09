import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HProductError) {
          return Center(child: Text('Error: ${state.error}'));
        }

        if (state is HProductSuccess) {
          final products = state.products;

          if (products.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 18,
              childAspectRatio: 163 / 288,
            ),
            itemBuilder: (context, index) {
              final apiProduct = products[index];
              debugPrint('Product: ${apiProduct.title}');
              debugPrint('Images: ${apiProduct.images}');
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
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

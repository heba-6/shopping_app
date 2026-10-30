import 'package:flutter/material.dart';
import 'package:shopping_app/core/helper/cart_helper.dart';
import 'package:shopping_app/core/helper/favourite_helper.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import '../../../domain/entities/search_product_entity.dart';

class SearchResults extends StatelessWidget {
  final List<SearchProductEntity> products;

  const SearchResults({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.58,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final searchProduct = products[index];

        final product = ProductsEntity(
          id: searchProduct.id,
          title: searchProduct.title,
          description: searchProduct.description,
          price: searchProduct.price,
          discount: searchProduct.discountPercentage,
          rating: searchProduct.rating,
          image: searchProduct.images,
        );

        return ProductItemCard(
          product: product,
          onTap: () {
            // Add product details navigation here if needed.
          },
          favoriteOnTap: () {
            FavouriteHelper.toggleFavourite(context, product);
          },
          addToCartOnTap: () {
            CartHelper.addToCart(context, product.id);
          },
        );
      },
    );
  }
}

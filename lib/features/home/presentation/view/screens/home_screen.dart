import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_assets/app_asset_image.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
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

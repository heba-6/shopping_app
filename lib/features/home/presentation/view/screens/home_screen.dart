import 'package:flutter/material.dart';
import 'package:shopping_app/core/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 16,
        childAspectRatio: 163 / 288,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ProductItem(
          discount: 30,
          image: imageUrl,
          onTap: () {},
          price: 100,
          rating: 4.5,
          title: "Eyeshadow Palette with Mirror",
          // favouriteOnTap: () {},
        );
      },
    );
  }
}

const String imageUrl =
    "https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/1.webp";

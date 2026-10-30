import 'package:flutter/material.dart';
import 'package:shopping_app/core/helper/cart_helper.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/features/product_details/data/model/product_model.dart';

import '../widgets/product_image_slider.dart';
import '../widgets/product_info_section.dart';
import '../widgets/reviews_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImageSlider(images: product.images),
                    const SizedBox(height: 16),
                    ProductInfoSection(product: product),
                    const SizedBox(height: 16),
                    ReviewsSection(reviews: product.reviews),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButon(
                title: "Add to cart",
                color: AppColors.black,
                textColor: AppColors.white,
                onTap: () {
                  CartHelper.addToCart(context, product.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

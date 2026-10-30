import 'package:flutter/material.dart';
import 'package:shopping_app/features/product_details/data/model/product_model.dart';
import 'package:shopping_app/features/product_details/data/model/review_model.dart';
import 'product_details_screen.dart';

class ProductDetailsPreview extends StatelessWidget {
  const ProductDetailsPreview({super.key});
  @override
  Widget build(BuildContext context) {
    final product = ProductModel(
      id: 1,
      title: 'T-shirt oversize',
      description:
          'Elevate your casual wardrobe with our Classic Red Pullover Hoodie. Crafted with a soft cotton blend for ultimate comfort, this vibrant red hoodie features a kangaroo pocket, adjustable drawstring hood, and ribbed cuffs for a snug fit. The timeless design ensures easy pairing with jeans or joggers for a relaxed yet stylish look, making it a versatile addition to your everyday attire',
      price: 250,
      discountPercentage: 20,
      rating: 4.5,
      images: [
        'https://picsum.photos/id/1011/600/600',
        'https://picsum.photos/id/1025/600/600',
        'https://picsum.photos/id/1035/600/600',
      ],
      reviews: [
        ReviewModel(
          userName: 'Ahmed',
          rating: 5,
          comment: 'Great quality and very comfortable.',
        ),
        ReviewModel(
          userName: 'Sara',
          rating: 4,
          comment: 'Nice fit, fast delivery.',
        ),
      ],
    );
    return ProductDetailsScreen(product: product);
  }
}

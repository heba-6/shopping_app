import 'package:flutter/material.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';

class SharedItemWidget extends StatelessWidget {
  const SharedItemWidget({
    super.key,
    required this.product,
    required this.onTap,
    this.favoriteOnTap,
    this.addToCartOnTap,
    this.isInCart = false,
  });

  final ProductsEntity product;
  final void Function()? onTap;
  final void Function()? favoriteOnTap;
  final void Function()? addToCartOnTap;
  final bool isInCart;

  @override
  Widget build(BuildContext context) {
    return ProductItemCard(
      product: product,
      onTap: onTap,
      favoriteOnTap: favoriteOnTap,
      addToCartOnTap: addToCartOnTap,
      isInCart: isInCart,
    );
  }
}

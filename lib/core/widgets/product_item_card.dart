import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.product,
    required this.onTap,
    this.favoriteOnTap,
    this.addToCartOnTap,
    this.isInCart = false,
    this.isFavourite = false,
    this.isFavouriteLoading = false,
  });

  final ProductsEntity product;
  final void Function()? onTap;
  final void Function()? addToCartOnTap;
  final void Function()? favoriteOnTap;
  final bool isInCart;

  // Favourite state
  final bool isFavourite;
  final bool isFavouriteLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.orangeLight, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: product.image.isNotEmpty
                            ? product.image.first
                            : '',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryOrange,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported_outlined),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 4,
                  top: 4,
                  child: IconButton(
                    tooltip: isFavourite
                        ? 'Remove from favourites'
                        : 'Add to favourites',
                    onPressed: isFavouriteLoading ? null : favoriteOnTap,
                    icon: isFavouriteLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            isFavourite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavourite ? AppColors.red : Colors.grey,
                          ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'EGP ${product.price.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  Card(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'Disc: ${product.discount}%',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.orangeLight, size: 16),
                      const SizedBox(width: 2),
                      Text(
                        '${product.rating}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const Spacer(),

                      InkWell(
                        onTap: addToCartOnTap,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            isInCart
                                ? Icons.shopping_cart
                                : Icons.shopping_cart_outlined,
                            color: AppColors.orangeLight,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

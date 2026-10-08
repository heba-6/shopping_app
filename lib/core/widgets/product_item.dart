import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.onTap,
    this.favoriteOnTap,
    this.addToCartOnTap,
    required this.title,
    required this.discount,
    required this.price,
    required this.rating,
    required this.image,
    this.isInCart = false,
  });

  final void Function()? addToCartOnTap;
  final void Function()? favoriteOnTap;
  final bool isInCart;

  final String title;
  final double discount;
  final double price;
  final double rating;
  final String image;
  final void Function()? onTap;

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
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: image,

                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                              color: AppColors.primaryOrange,
                              padding: EdgeInsets.all(60),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 4,
                  child: IconButton(
                    onPressed: favoriteOnTap,
                    icon: Icon(Icons.favorite_border_rounded),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "EGP $price",
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  Card(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        softWrap: true,
                        maxLines: 2,
                        "Disc:$discount%",
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
                      SizedBox(width: 2),
                      Text(
                        "$rating",
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      Spacer(),
                      InkWell(
                        onTap: addToCartOnTap,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: EdgeInsets.all(4),
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

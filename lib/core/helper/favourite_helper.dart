import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/products_by_category/domain/entities/product_by_category_entity.dart';

class FavouriteHelper {
  static Future<void> toggleFavourite(
    BuildContext context,
    ProductsEntity product,
  ) async {
    final result = await context.read<FavouriteCubit>().toggleFavourite(
      product,
    );

    if (!context.mounted) return;

    if (result is Success<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Favourite updated successfully')),
      );
    } else if (result is Error<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.messageError),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  static Future<void> toggleCategoryFavourite(
    BuildContext context,
    ProductByCategoryEntity product,
  ) async {
    final result = await context.read<FavouriteCubit>().toggleCategoryFavourite(
      product,
    );

    if (!context.mounted) return;

    if (result is Success<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Favourite updated successfully')),
      );
    } else if (result is Error<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.messageError),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }
}

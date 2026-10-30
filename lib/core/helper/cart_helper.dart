import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';

class CartHelper {
  static Future<void> addToCart(BuildContext context, int productId) async {
    final result = await context.read<CartCubit>().addToCart(productId);

    if (!context.mounted) return;

    if (result is Success<void>) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item added to cart successfully')),
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

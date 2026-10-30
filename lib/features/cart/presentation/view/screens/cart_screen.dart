import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CartView();
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: BlocConsumer<CartCubit, CartState>(
        listenWhen: (previous, current) =>
            current.errorMessage != null &&
            current.errorMessage != previous.errorMessage,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.red,
              ),
            );
        },
        builder: (context, state) {
          if (state.status == CartStatus.loading && state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryOrange),
            );
          }

          if (state.status == CartStatus.failure && state.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 55,
                      color: AppColors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage ?? 'Something went wrong',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().getCart();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/empty_cart.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AppSectionCubit>().changeTab(0);
                    },
                    child: const Text('Go to Home'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primaryOrange,
                  onRefresh: () {
                    return context.read<CartCubit>().getCart();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];

                      return CartItemWidget(
                        item: item,
                        isDeleting: state.deletingProductId == item.productId,
                        onIncrease: () {
                          context.read<CartCubit>().increaseQuantity(
                            item.productId,
                          );
                        },
                        onDecrease: () {
                          context.read<CartCubit>().decreaseQuantity(
                            item.productId,
                          );
                        },
                        onDelete: () async {
                          final result = await context
                              .read<CartCubit>()
                              .deleteCartItem(item.productId);

                          if (!context.mounted) return;

                          if (result is Success<void>) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product removed from cart'),
                                backgroundColor: AppColors.green,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              _CartSummary(
                subtotal: state.subtotal,
                totalQuantity: state.totalQuantity,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final double subtotal;
  final int totalQuantity;

  const _CartSummary({required this.subtotal, required this.totalQuantity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _summaryRow(context, 'Items', '$totalQuantity'),
            const SizedBox(height: 8),
            _summaryRow(
              context,
              'Subtotal',
              '\$${subtotal.toStringAsFixed(2)}',
            ),
            const Divider(height: 24),
            _summaryRow(
              context,
              'Total',
              '\$${subtotal.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Checkout is not available yet'),
                    ),
                  );
                },
                child: Text(
                  'Checkout',
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final theme = Theme.of(context);

    final labelStyle = isTotal
        ? theme.textTheme.titleMedium?.copyWith(color: AppColors.deepOrange)
        : theme.textTheme.labelMedium;

    final valueStyle = isTotal
        ? theme.textTheme.titleMedium?.copyWith(color: AppColors.deepOrange)
        : theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Text(value, style: valueStyle),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:shopping_app/features/favourite/presentation/view_model/favourite_state.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/core/networking/result_api.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FavouriteView();
  }
}

class _FavouriteView extends StatelessWidget {
  const _FavouriteView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favourites'), centerTitle: true),
      body: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
          if (state.status == FavouriteStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == FavouriteStatus.loading && state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryOrange),
            );
          }

          if (state.status == FavouriteStatus.failure && state.items.isEmpty) {
            return _ErrorView(
              message: state.errorMessage ?? 'Failed to load favourites.',
              onRetry: () {
                context.read<FavouriteCubit>().getFavourites();
              },
            );
          }

          if (state.items.isEmpty) {
            return const _EmptyFavouriteView();
          }

          return RefreshIndicator(
            color: AppColors.primaryOrange,
            onRefresh: () => context.read<FavouriteCubit>().getFavourites(),
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final product = state.items[index];

                return ProductItemCard(
                  product: product,
                  isFavourite: state.isFavourite(product.id),
                  isFavouriteLoading: state.isProcessing(product.id),
                  favoriteOnTap: () {
                    _toggleFavourite(context, product);
                  },
                  onTap: () {},
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _toggleFavourite(
    BuildContext context,
    ProductsEntity product,
  ) async {
    final result = await context.read<FavouriteCubit>().toggleFavourite(
      product,
    );

    if (!context.mounted) return;

    final message = switch (result) {
      Success<void>() => 'Removed from favourites',
      Error<void>() => 'Could not update favourites',
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}

class _EmptyFavouriteView extends StatelessWidget {
  const _EmptyFavouriteView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/favorite.png',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          Text(
            'There are no products in your',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'favourite list',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56, color: AppColors.red),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}

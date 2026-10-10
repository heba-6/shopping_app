import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/widgets/product_item_card.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().intent(HProducts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping App'), centerTitle: false),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HProductError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error: ${state.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is HProductSuccess) {
            final products = state.products;

            if (products.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 18,
                childAspectRatio: 163 / 288,
              ),
              itemBuilder: (context, index) {
                final apiProduct = products[index];

                final product = ProductsEntity(
                  id: apiProduct.id,
                  title: apiProduct.title,
                  description: apiProduct.description,
                  price: apiProduct.price,
                  discount: apiProduct.discountPercentage,
                  rating: apiProduct.rating,
                  image: apiProduct.images,
                );

                return ProductItemCard(
                  product: product,
                  onTap: () {},
                  favoriteOnTap: () {},
                  addToCartOnTap: () {},
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

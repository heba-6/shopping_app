import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_state.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view/screens/cart_screen.dart';
import 'package:shopping_app/features/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:shopping_app/features/account/presentation/view/screens/account_screen.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      BlocProvider<HomeCubit>(
        create: (context) => serviceLocator<HomeCubit>()..loadHome(),
        child: const HomeScreen(),
      ),
      const CartScreen(),
      const FavoriteScreen(),
      const AccountScreen(),
    ];

    return BlocBuilder<AppSectionCubit, AppSectionState>(
      builder: (context, state) {
        final cubit = context.read<AppSectionCubit>();

        return Scaffold(
          body: screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: cubit.changeTab,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_state.dart';

class AppSectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> Screens = const [
      Center(child: Text('Home Screen')),
      Center(child: Text('Cart Screen')),
      Center(child: Text('Favourite Screen')),
      Center(child: Text('Account Screen')),
    ];
    return BlocBuilder<AppSectionCubit, AppSectionState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AppSectionCubit>(context);

        return Scaffold(
          body: Screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeTab(index);
            },
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

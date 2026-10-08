import 'package:flutter/material.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesManager.home,
      routes: {
        RoutesManager.home: (context) =>
            const Scaffold(body: SafeArea(child: HomeScreen())),
      },
    );
  }
}

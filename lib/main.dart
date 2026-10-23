import 'package:flutter/material.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesManager.onBoarding,
      routes: {
        RoutesManager.onBoarding: (context) => const OnboardingScreen(),
        RoutesManager.home: (context) =>
            const Scaffold(body: SafeArea(child: HomeScreen())),
      },
    );
  }
}

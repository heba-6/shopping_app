import 'package:flutter/material.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/hello_screen.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeManager.light,

      initialRoute: RoutesManager.hello,
      routes: {
        RoutesManager.onBoarding: (context) => const OnboardingScreen(),
        RoutesManager.hello: (context) => const HelloScreen(),
        RoutesManager.home: (context) =>
            const Scaffold(body: SafeArea(child: HomeScreen())),
      },
    );
  }
}

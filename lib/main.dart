import 'package:flutter/material.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

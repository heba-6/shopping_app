import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManager.light,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesManager.onBoarding,
      routes: {
        RoutesManager.onBoarding: (context) => const OnboardingScreen(),
        RoutesManager.home: (context) =>
            const Scaffold(body: SafeArea(child: HomeScreen())),
        RoutesManager.appSection: (context) => BlocProvider(
          create: (context) => AppSectionCubit(),
          child: AppSectionScreen(),
        ),
      },
    );
  }
}

import 'package:shopping_app/core/storage/token_storage.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  await TokenStorage().saveToken(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhYzU5MjNjYjMwZmIxZjQ3OGViYjI4YSIsImlhdCI6MTc5MTY3NjQ0NCwiZXhwIjoxNzk0MjY4NDQ0fQ.0wukQfH4pk5CPt10KGUhdGQlUN0xwZk7HPU1NCZV2bM',
  );

  runApp(
    MyApp(
      initialRoute: seenOnboarding
          ? RoutesManager.home
          : RoutesManager.onBoarding,
      // initialRoute: RoutesManager.onBoarding,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: initialRoute,

      routes: {
        RoutesManager.onBoarding: (context) => const OnboardingScreen(),

        RoutesManager.home: (context) => BlocProvider(
          create: (context) => serviceLocator<HomeCubit>(),
          child: Scaffold(body: SafeArea(child: HomeScreen())),
        ),
      },
    );
  }
}

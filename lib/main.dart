import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/features/account/presentation/view/screens/account_screen.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesManager.account,
      routes: {
        RoutesManager.onBoarding: (context) => const OnboardingScreen(),
        RoutesManager.home: (context) =>
            const Scaffold(body: SafeArea(child: HomeScreen())),
        RoutesManager.account: (context) => BlocProvider(
          create: (_) => serviceLocator<AccountCubit>()..loadProfile(),
          child: const AccountScreen(),
        ),
      },
    );
  }
}

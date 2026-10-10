// import 'package:flutter/material.dart';
// import 'package:shopping_app/core/route/app_route.dart';
// import 'package:shopping_app/core/di/service_locator.dart';
// import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
// import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';

// void main() {
//   configureDependencies();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: RoutesManager.onBoarding,
//       routes: {
//         RoutesManager.onBoarding: (context) => const OnboardingScreen(),

//         RoutesManager.appSection: (context) => const AppSectionScreen(),

//         RoutesManager.home: (context) => const AppSectionScreen(),
//       },
//     );
//   }
// }
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

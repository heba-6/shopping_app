import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/helper/app_secure_storage.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/core/storage/token_storage.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/auth/data/api/auth_api.dart';
import 'package:shopping_app/features/auth/data/repo/repo/auth_repo_imp.dart';
import 'package:shopping_app/features/auth/data/repo/data_source/auth_data_source_imp.dart';
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/hello_screen.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';
import 'package:shopping_app/features/search/presentation/view/screens/search_screen.dart';
import 'package:shopping_app/features/search/presentation/view_model/search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  await TokenStorage().saveToken(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhYzU5MjNjYjMwZmIxZjQ3OGViYjI4YSIsImlhdCI6MTc5MTY1MTA0NSwiZXhwIjoxNzk0MjQzMDQ1fQ.j4AOpvVMlcskmgBfRNhqz2bPZRaWKYUmLtqWn6B1OK8',
  );

  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    MyApp(
      initialRoute: seenOnboarding
          ? RoutesManager.hello
          : RoutesManager.onBoarding,
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
        RoutesManager.hello: (context) => const HelloScreen(),
        RoutesManager.home: (context) => BlocProvider(
          create: (_) => serviceLocator<HomeCubit>(),
          child: const Scaffold(body: SafeArea(child: HomeScreen())),
        ),
        RoutesManager.search: (context) => BlocProvider(
          create: (_) => serviceLocator<SearchCubit>(),
          child: const SearchScreen(),
        ),
        RoutesManager.appSection: (context) => BlocProvider(
          create: (_) => AppSectionCubit(),
          child: AppSectionScreen(),
        ),
        RoutesManager.login: (context) => BlocProvider(
          create: (_) {
            final appStorage = AppSecureStorage(const FlutterSecureStorage());

            return LoginCubit(
              LoginUseCase(
                AuthRepoImp(AuthDataSourceImp(AuthApi()), appStorage),
              ),
              appStorage,
            );
          },
          child: LoginScreen(),
        ),
      },
    );
  }
}

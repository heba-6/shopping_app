import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/helper/app_secure_storage.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/core/route/initial_route.dart';
import 'package:shopping_app/core/utils/my_bloc_observer.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/auth/data/api/auth_api.dart';
import 'package:shopping_app/features/auth/data/repo/auth_repo_imp.dart';
import 'package:shopping_app/features/auth/data/repo/data_source/auth_data_source_imp.dart';
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/hello_screen.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  Bloc.observer = MyBlocObserver();

  String initRoute = await initialRoute();

  runApp(MyApp(initialRoute: initRoute));
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
          create: (context) => serviceLocator<HomeCubit>(),
          child: const Scaffold(body: SafeArea(child: HomeScreen())),
        ),
        RoutesManager.appSection: (context) => BlocProvider(
          create: (context) => AppSectionCubit(),
          child: AppSectionScreen(),
        ),
        RoutesManager.login: (context) => BlocProvider(
          create: (context) {
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

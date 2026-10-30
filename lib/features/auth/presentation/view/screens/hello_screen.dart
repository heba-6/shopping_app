import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shopping_app/core/helper/app_secure_storage.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/auth/data/api/auth_api.dart';
import 'package:shopping_app/features/auth/data/repo/repo/auth_repo_imp.dart';
import 'package:shopping_app/features/auth/data/repo/data_source/auth_data_source_imp.dart';
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/register_screen.dart';
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleStyle = theme.textTheme.titleMedium?.copyWith(fontWeight: .bold);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset('assets/images/rafiki.png', height: 240),
              const SizedBox(height: 32),
              Text('Hello!', style: theme.textTheme.titleLarge),
              const Spacer(flex: 3),
              _buildButton(
                text: 'Sign up',
                bgColor: AppColors.orangeLight,
                textColor: AppColors.white,
                style: titleStyle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildButton(
                text: 'Login',
                bgColor: AppColors.backGroundGrey,
                textColor: AppColors.orangeLight,
                borderColor: AppColors.orangeLight,
                style: titleStyle,
                onTap: () {
                  final secureStorage = AppSecureStorage(
                    const FlutterSecureStorage(),
                  );

                  final loginUseCase = LoginUseCase(
                    AuthRepoImp(AuthDataSourceImp(AuthApi()), secureStorage),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<LoginCubit>(
                        create: (_) => LoginCubit(loginUseCase, secureStorage),
                        child: const LoginScreen(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
    TextStyle? style,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1.5)
              : null,
        ),
        child: Text(text, style: style?.copyWith(color: textColor)),
      ),
    );
  }
}

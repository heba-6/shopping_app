import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundGrey,
      body: const SafeArea(
        child: SizedBox.expand(),
      ),
    );
  }
}

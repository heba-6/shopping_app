import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class RegisterScreen extends StatelessWidget {
const RegisterScreen({super.key});

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

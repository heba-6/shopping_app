import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/utils/app_dialog.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/core/widgets/custom_text_field.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/register_screen.dart';
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextTheme theme;
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context).textTheme;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          AppDialogs.showLoadingDialog(context);
        }

        if (state is LoginSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(RoutesManager.appSection);
        }

        if (state is LoginError) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In'), centerTitle: false),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 40),
              Text("Email", style: theme.bodyMedium),
              CustomTextFormField(
                controller: email,
                hintText: "youusefmhmd30@gmail.com",
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter your email';
                  }
                  final bool isValidEmail = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(text);

                  if (!isValidEmail) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              Text("Password", style: theme.bodyMedium),
              CustomTextFormField(
                controller: password,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                hintText: "Enter your password",
                isPassword: true,
              ),
              SizedBox(height: 40),
              CustomButon(
                title: "Login",
                onTap: () async {
                  await context.read<LoginCubit>().intent(
                    LoginWithEmailPassword(email.text.trim(), password.text),
                  );
                },
                textColor: AppColors.white,
              ),
            ],
          ),
        ),

        floatingActionButtonLocation: .centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => AppSectionCubit(),
                  child: AppSectionScreen(),
                ),
              ),
            );
          },
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: AppColors.black),
                ),
                TextSpan(
                  text: "Sign Up",
                  style: TextStyle(fontWeight: .bold, color: AppColors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

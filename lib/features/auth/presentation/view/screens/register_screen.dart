import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/route/app_route.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/utils/validators.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/core/widgets/custom_text_field.dart';
import 'package:shopping_app/features/auth/data/model/register_request_model.dart';
import 'package:shopping_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart';
import 'package:shopping_app/features/auth/presentation/view_model/register/register_cubit.dart';
import 'package:shopping_app/features/auth/presentation/view_model/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<RegisterCubit>().register(
      RegisterRequestModel(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => serviceLocator<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushReplacementNamed(context, RoutesManager.login);
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoading;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Sign up', style: TextStyle(fontWeight: .bold)),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: 'Your name',
                        keyboardType: TextInputType.name,
                        validator: Validators.name,
                      ),
                      const SizedBox(height: 16),
                      Text('Phone', style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _phoneController,
                        hintText: '01012345678',
                        keyboardType: TextInputType.phone,
                        validator: Validators.phone,
                      ),
                      const SizedBox(height: 16),
                      Text('Email', style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'example@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 16),
                      Text('Password', style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: '••••••••',
                        isPassword: true,
                        validator: Validators.password,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Confirm password',
                        style: theme.textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _confirmController,
                        hintText: '••••••••',
                        isPassword: true,
                        action: TextInputAction.done,
                        validator: (v) => Validators.confirmPassword(
                          v,
                          _passwordController.text,
                        ),
                      ),
                      const SizedBox(height: 24),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButon(
                              title: 'Sign up',
                              textColor: AppColors.white,
                              onTap: () => _submit(context),
                            ),
                      const SizedBox(height: 24),
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.login,
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              style: theme.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

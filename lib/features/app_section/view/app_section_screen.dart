import 'package:flutter/material.dart';
import 'package:shopping_app/features/home/presentation/view/screens/home_screen.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const HomeScreen());
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

abstract class ThemeManager {
  static ThemeData light = ThemeData(
    // Color scaffold
    scaffoldBackgroundColor: AppColors.backGroundGrey,

    // App Bar
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.backGroundGrey,
      centerTitle: true,
      foregroundColor: AppColors.black,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: .w600,
        color: AppColors.black,
      ),
    ),

    // Text Form Field Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backGroundGrey,
      hintStyle: TextStyle(
        fontWeight: .w400,
        fontSize: 16,
        color: AppColors.black,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.orangeLight, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.grey, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.white, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.red, width: 1),
      ),
    ),

    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: AppColors.white,
        fontSize: 18,
        fontWeight: .w600,
      ),

      bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 22,
        fontWeight: .w600,
      ),

      bodyMedium: TextStyle(
        fontSize: 18,
        color: AppColors.black,
        fontWeight: .w400,
      ),

      labelMedium: TextStyle(
        fontSize: 14,
        color: AppColors.black,
        fontWeight: .w400,
      ),

      labelLarge: TextStyle(
        fontSize: 20,
        color: AppColors.black,
        fontWeight: .w500,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 40,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.backGroundGrey,
      selectedItemColor: AppColors.orangeLight,
      unselectedItemColor: AppColors.greyDark,
      selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: .w500),
      unselectedLabelStyle: TextStyle(fontWeight: .w500, fontSize: 14),
      selectedIconTheme: IconThemeData(size: 24),
    ),
  );
}

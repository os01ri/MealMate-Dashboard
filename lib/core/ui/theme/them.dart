import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData getColor() {
    return ThemeData(
      fontFamily: 'Almarai',
      primaryColor: AppColors.mainColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
        backgroundColor: AppColors.mainColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          AppColors.mainColor.value,
          const {
            50: AppColors.mainColor,
            100: AppColors.mainColor,
            200: AppColors.mainColor,
            300: AppColors.mainColor,
            400: AppColors.mainColor,
            500: AppColors.mainColor,
            600: AppColors.mainColor,
            700: AppColors.mainColor,
            800: AppColors.mainColor,
            900: AppColors.mainColor,
          },
        ),
      ).copyWith(secondary: AppColors.secondaryColor),
    );
  }
}

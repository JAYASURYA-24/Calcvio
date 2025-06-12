import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightCard,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.lightTextPrimary),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.lightSliderActive,
      inactiveTrackColor: AppColors.lightSliderInactive,
      thumbColor: AppColors.lightSliderThumb,
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkCard,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.darkSliderActive,
      inactiveTrackColor: AppColors.darkSliderInactive,
      thumbColor: AppColors.darkSliderThumb,
    ),
    useMaterial3: true,
  );
}

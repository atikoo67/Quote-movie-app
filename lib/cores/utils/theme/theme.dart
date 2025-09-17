import 'package:flutter/material.dart';
import 'package:quote/cores/utils/constant/colors.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.background,
  textTheme: AppTextStyle.textTheme,
  iconTheme: IconThemeData(color: AppColor.buttonColor, size: 30),
  colorScheme: ColorScheme.dark(
    primary: AppColor.buttonColor,
    secondary: AppColor.mediumTitle,
    surface: AppColor.surface,
    tertiary: AppColor.largeTitle,
    error: AppColor.errorColor,
  ),
);

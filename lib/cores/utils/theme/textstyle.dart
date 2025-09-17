import 'package:flutter/material.dart';
import 'package:quote/cores/utils/constant/colors.dart';

class AppTextStyle {
  static final textTheme = TextTheme(
    bodyLarge: TextStyle(
      color: AppColor.largeTitle,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      fontStyle: FontStyle.italic,
      color: AppColor.mediumTitle,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: AppColor.largeTitle,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: AppColor.mediumTitle,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(color: AppColor.largeTitle, fontSize: 15),
    headlineLarge: TextStyle(
      color: AppColor.link,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );
}

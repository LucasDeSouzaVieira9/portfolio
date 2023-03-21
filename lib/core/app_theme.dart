import 'package:flutter/material.dart';
import 'package:portfolio/core/app_colors.dart';

class ThemeTextStyle {
  static TextStyle bold() => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor1,
      );
  static TextStyle medium() => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor1,
      );
  static TextStyle regular() => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 13,
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor1,
      );
  static TextStyle body1Bold() => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor1,
      );
  static TextStyle body1Medium() => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor1,
      );
  static TextStyle body1Regular() => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 13,
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.normal,
        color: AppColors.textColor1,
      );
  static TextStyle h3HeadlineBold() => const TextStyle(
        fontFamily: 'Poppins',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 17,
        color: AppColors.textColor1,
      );
  static TextStyle h3HeadlineMedium() => const TextStyle(
        fontFamily: 'Poppins',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 17,
        color: AppColors.textColor1,
      );
  static TextStyle h4HeadlineBold() => const TextStyle(
        fontFamily: 'Poppins',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: AppColors.textColor1,
      );
  static TextStyle h4HeadlineMedium() => const TextStyle(
        fontFamily: 'Poppins',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: AppColors.textColor1,
      );
}

import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppStyles {
  static const displayLarge = TextStyle(
    fontFamily: 'sf',
    height: 1.1,
    fontSize: 40,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    letterSpacing: -1,
  );

  static const displaySmall = TextStyle(
    fontFamily: 'sf',
    height: 1,
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: -1,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'sf',
    height: 1.3,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: -1,
  );
  static const labelMedium = TextStyle(
    fontFamily: 'sf',
    height: 1.1,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: -1,
  );

}

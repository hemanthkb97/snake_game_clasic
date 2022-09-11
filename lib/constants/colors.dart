import 'package:flutter/animation.dart';

class AppColors {
  static final AppColors _appColors = AppColors._internal();

  static Color colorYello = const Color(0xff96d202);
  static Color colorGrey = const Color(0xff6dac85);

  factory AppColors() {
    return _appColors;
  }
  AppColors._internal();
}

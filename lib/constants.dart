import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFB497CC);
  static const Color darkPurple = Color(0xFF6B4C7C);
  static const Color mediumPurple = Color(0xFF4A3960);
  static const Color darkBg = Color(0xFF2D1B3D);
  static const Color black = Color(0xFF000000);

  // Gradient Colors
  static const List<Color> loginGradient = [
    Color(0xFF6B4C7C),
    Color(0xFF2D1B3D),
    Color(0xFF000000),
  ];

  static const List<Color> mainGradient = [
    Color(0xFF6B4C7C),
    Color(0xFF4A3960),
    Color(0xFF2D1B3D),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF8B6FA8),
    Color(0xFF4A3960),
  ];

  // Semantic Colors
  static const Color success = Colors.greenAccent;
  static const Color error = Colors.redAccent;
  static const Color warning = Colors.amber;
}

class AppDimens {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 20.0;

  static const double radiusSmall = 10.0;
  static const double radiusMedium = 15.0;
  static const double radiusLarge = 20.0;

  static const double fontSmall = 12.0;
  static const double fontMedium = 14.0;
  static const double fontLarge = 18.0;
  static const double fontXLarge = 28.0;
  static const double fontXXLarge = 32.0;
}

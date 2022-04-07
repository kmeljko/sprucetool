import 'package:flutter/material.dart';

class AppColors {
  // static Color mainColor = Colors.green;
  // static Color textColor = Colors.white;
  // static Color backgroundColor = Color(0xFF3c9f40);

  static Color mainColor = Colors.black;
  static Color textColor = Colors.white.withOpacity(0.7);
  static Color backgroundColor = Color(0xFF0a0a0a);
  static MaterialColor createMaterialColor() {
    Color color = mainColor;
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static Color shadowColor() {
    double amount = 0.1;
    final hsl = HSLColor.fromColor(mainColor);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}

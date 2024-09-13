import 'package:flutter/material.dart';

const kPrimaryColor = Color(0XFFFF7643);
const kPrimaryLightColor = Color(0XFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFffa53e), Color(0xFFff7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

Color lighten(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  return hslLight.toColor();
}

Color darken(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

Map<int, Color> generateShadeMap(Color color) {
  return {
    50: lighten(color, 0.9),
    100: lighten(color, 0.8),
    200: lighten(color, 0.6),
    300: lighten(color, 0.4),
    400: lighten(color, 0.2),
    500: color, // Primary value
    600: darken(color, 0.1),
    700: darken(color, 0.2),
    800: darken(color, 0.3),
    900: darken(color, 0.4),
  };
}

final shadeMap = generateShadeMap(kPrimaryColor);

final primaryMaterialColor = MaterialColor(kPrimaryColor.value, shadeMap);

class MyColor extends MaterialStateColor {
  const MyColor() : super(_defaultColor);

  static const int _defaultColor = 0XFFFF7643;
  static const int _pressedColor = 0XFFFFECDF;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

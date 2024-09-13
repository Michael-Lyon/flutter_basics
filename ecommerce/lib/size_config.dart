import 'package:flutter/material.dart';

class SizeConfig {
 static MediaQueryData? _mediaQueryData; // Make _mediaQueryData nullable
  static double? screenWidth; // Make screenWidth nullable
  static double? screenHeight; // Make screenHeight nullable
  static double? defaultSize; // Make defaultSize nullable
  static Orientation? orientation; // Make orientation nullable

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }

}


// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight as double;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth as double;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

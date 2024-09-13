import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';
import 'package:first_app/utils.dart';

void main() {
  runApp( MaterialApp(
    home: Scaffold(
      backgroundColor: const Color(0xFFFFBF00),
      body: GradientContainer(colorList: MyColors.fullGradient2),
    ),
  ));
}

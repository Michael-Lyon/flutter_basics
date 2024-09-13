import 'package:flutter/material.dart';
import 'package:first_app/utils.dart';
import 'dart:math';
import "package:first_app/dice_roller.dart";

class GradientContainer extends StatelessWidget {
  final List<Color> colorList;
  GradientContainer({super.key, required this.colorList});
  var activeImage = "assets/dice-images/dice-3.png";

  void rollDie() {
    List<String> diceImages = MyColors.diceImages;
    Random random = Random();
    int index = random.nextInt(diceImages.length);
    activeImage = diceImages[index];
  }

  @override
  Widget build(context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colorList,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const Center(
          child:  DiceRoller(),
        ));
  }
}

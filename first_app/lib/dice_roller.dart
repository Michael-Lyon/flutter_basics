import "package:flutter/material.dart";
import 'package:first_app/utils.dart';
import 'dart:math';

final Random random = Random();
final List<String> diceImages = MyColors.diceImages;

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeImage = "assets/dice-images/dice-3.png";
  void rollDie() {
    int index = random.nextInt(diceImages.length);
    setState(() {
    activeImage = diceImages[index];
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          activeImage,
          height: 250,
        ),
        const SizedBox(height: 25),
        TextButton(
          onPressed: rollDie,
          style: TextButton.styleFrom(
              backgroundColor: MyColors.accentColor,
              foregroundColor: MyColors.secondaryColor,
              elevation: 4,
              textStyle: const TextStyle(
                fontSize: 25,
              )),
          child: const Text("Roll Die"),
        )
      ],
    );
  }
}

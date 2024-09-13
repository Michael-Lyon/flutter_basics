import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final void Function(String screen) startQuiz;
  const StartScreen(this.startQuiz, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
          Image.asset(
            "assets/images/quiz-logo.png",
            height: 400,
          ),
          const Text("Learn Flutter the fun way!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF4F6FB),
              )),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.arrow_right_alt,
              color: Color(0xFF14BFD2),
            ),
            onPressed: () {
              startQuiz("questions-screen");
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFF4F6FB),
              elevation: 4,
            ),
            label: const Text("Start Quiz",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF14BFD2),
                )),
          )
        ]));
  }
}

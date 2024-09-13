import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/question_screen.dart';
import 'package:adv_basics/results_screen.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  String activescreen = "start-screen";

  List<String> selectedAnswers = [];

  void switchScreen(String screen) {
    setState(() {
      activescreen = screen;
    });
  }

  void chooseAnswers(String answer) {
      selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activescreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);
    if (activescreen == "questions-screen") {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswers);
    } else if (activescreen == "results-screen") {
      screenWidget =
          ResultsScreen(chosenAnswers: selectedAnswers, reset: switchScreen);
      selectedAnswers = [];
    }
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: const Color(0xFF2463EB),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF2463EB), Color(0xFF14BFD2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft)),
            child: screenWidget),
      ),
    );
  }
}

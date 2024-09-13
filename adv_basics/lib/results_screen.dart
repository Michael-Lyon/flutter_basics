import 'package:adv_basics/questions_summary.dart';
import 'package:adv_basics/utility/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.reset});

  final int correctCount = 0;
  final List<String> chosenAnswers;
  final void Function(String screen) reset;

  // One way
  int countScore() {
    int count = 0;
    for (int i = 0; i < chosenAnswers.length; i++) {
      String answer = chosenAnswers[i];
      String correctAnswer = questions[i].answers[0];

      if (answer == correctAnswer) {
        count++;
      }
    }
    return count;
  }

  // another way
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].question,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final int score = countScore();
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $score out of ${chosenAnswers.length}  questions correctly!',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: MyStyle.colors['accent'],
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summary: getSummaryData()),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                reset("questions-screen");
              },
              child: Text(
                'Restart Quiz!',
                style: TextStyle(
                  backgroundColor: MyStyle.constColors['secondary'],
                  color: MyStyle.constColors['accent'],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/utility/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'models/quiz_quest.dart';

class QuestionsScreen extends StatefulWidget {
  final void Function(String answer) onSelectAnswer;

  const QuestionsScreen({super.key, required this.onSelectAnswer});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAAnswer) {
    // widget is a built in memeber variable that allows us to access a function
    widget.onSelectAnswer(selectedAAnswer);
    setState(() {      
        currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              currentQuestion.question,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: MyStyle.colors['accent'],
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentQuestion.getShuffledAnswer().map(
                  (answer) => AnswerButton(
                      text: answer,
                      function: () {
                        answerQuestion(answer);
                      }),
                ),
          ],
        ),
      ),
    );
  }
}

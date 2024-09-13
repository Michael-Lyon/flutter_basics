import 'package:adv_basics/utility/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  /// A widget that displays a summary of questions.
  ///
  /// The [QuestionsSummary] widget takes a list of summary data, where each item in the list represents a question summary. Each question summary should be a map with the following keys:
  ///   - 'question_index': An integer representing the question index.
  ///   - 'question': A string representing the question.
  ///   - 'user_answer': A string representing the user's answer to the question.
  ///   - 'correct_answer': A string representing the correct answer to the question.
  ///
  /// The [QuestionsSummary] widget displays the question index, question, user's answer, and correct answer for each question in a column layout.
// class QuestionsSummary extends StatelessWidget {
  /// Creates a [QuestionsSummary] widget.
  ///
  /// The [summary] parameter is a list of question summary data.
  // const QuestionsSummary({Key? key, required this.summary}) : super(key: key);

  const QuestionsSummary({super.key, required this.summary});

  final List<Map<String, Object>> summary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summary.map((data) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ((data['question_index'] as int) + 1).toString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: MyStyle.constColors["background"]),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // textAlign: TextAlign.center,
                              data['question'] as String,
                              style: GoogleFonts.poppins(
                                textStyle:
                                    TextStyle(color: MyStyle.constColors["accent"]),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(),
                            Text(
                              data['user_answer'] as String,
                              // textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: MyStyle.constColors["accent"]),
                            ),
                            Text(
                              data['correct_answer'] as String,
                              // textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: MyStyle.constColors["accent"]),
                            ),
                          ],
                        ),
                      
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

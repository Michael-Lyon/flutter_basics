import 'package:flutter/material.dart';
import 'package:adv_basics/utility/my_styles.dart';
import 'package:google_fonts/google_fonts.dart';


class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.text, required this.function});

  final String text;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            backgroundColor: MyStyle.colors['secondary'],
            foregroundColor: MyStyle.colors['accent'],
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45))),
        onPressed: () {
          function();
        },
        child:  Text(text, textAlign: TextAlign.center, style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

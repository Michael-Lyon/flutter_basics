import 'package:adv_basics/quiz.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF2463EB),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF2463EB), Color(0xFF14BFD2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft),
          ),
          child: const Quiz(),
        ),
      ),
    ),
  );
}

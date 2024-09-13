import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/utils/snack.dart';
import 'package:meals/widgets/meal_detail.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
      {super.key, required this.meal, required this.onToggleFavouriteMeal});

  final void Function(Meal meal) onToggleFavouriteMeal;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
              onPressed: () {
                onToggleFavouriteMeal(meal);
              },
              icon: const Icon(Icons.star))
        ],
      ),
      body: SingleChildScrollView(child: MealDetailWidget(meal: meal)),
    );
  }
}

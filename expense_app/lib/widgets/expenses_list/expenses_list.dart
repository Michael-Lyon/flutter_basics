import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  final void Function(Expense expense) removeExpense;

  const ExpensesList(
      {super.key, required this.expensesList, required this.removeExpense});

  @override
  Widget build(BuildContext context) {
    int size = expensesList.length;
    return ListView.builder(
      itemCount: size,
      itemBuilder: (context, index) {
        return SizedBox(
            // height: 100,
            child: Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(1),
            margin: Theme.of(context).cardTheme.margin,
          ),
          onDismissed: (direction) {
            removeExpense(expensesList[index]);
          },
          key: ValueKey(expensesList[index]),
          child: ExpensesItem(expense: expensesList[index]),
        ),
        );
      },
    );
  }
}

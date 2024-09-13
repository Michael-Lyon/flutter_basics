import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:expense_app/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
        title: "Movies",
        amount: 10.99,
        category: Category.leisure,
        created: DateTime.now()),
    Expense(
        title: "Courses",
        amount: 90.99,
        category: Category.work,
        created: DateTime.now()),
    Expense(
        title: "Maldives",
        amount: 100.99,
        category: Category.travel,
        created: DateTime.now()),
    Expense(
        title: "MacBook Pro M1",
        amount: 1099.99,
        category: Category.work,
        created: DateTime.now()),
  ];

  void _addNewExpense(Expense newExpense) {
    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _removeNewExpense(Expense newExpense) {
    final expenseIndex = _expenses.indexOf(newExpense);
    setState(() {
      _expenses.remove(newExpense);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); // clear snackbar

    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Undo Change"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _expenses.insert(expenseIndex, newExpense);
              });
            }),
      ),
    );
  }

  void _addExpenseOverlay() {
    //  code to open an overlay
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    showModalBottomSheet(
      useSafeArea: true,
        backgroundColor: isDarkMode ? const Color(0xff000000) : Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            addExpense: _addNewExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text("No Expenses Found. Start adding some!"),
    );

    if (_expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _expenses,
        removeExpense: _removeNewExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _addExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.m,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Chart(expenses: _expenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}

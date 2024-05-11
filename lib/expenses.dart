import 'package:expense_trakker/expensetype.dart';
import 'package:expense_trakker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_trakker/expenses_list.dart';
import 'package:expense_trakker/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> registeredExpense = [
    Expense(
        name: 'Flutter Cource',
        amount: 450,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        name: 'Movie',
        amount: 250,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _expenseaddoverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddexpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      registeredExpense.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget maincontent = const Center(
      child: Text("No expense found. Try adding some"),
    );
    if (registeredExpense.isNotEmpty) {
      maincontent = ExpenseList(
        expense: registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("ADD EXPENSE "),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: _expenseaddoverlay,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: width < 500
            ? Column(
                children: [
                  Chart(expenses: registeredExpense),
                  Expanded(child: maincontent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: registeredExpense)),
                  Expanded(child: maincontent)
                ],
              ));
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

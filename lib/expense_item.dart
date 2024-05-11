import 'package:flutter/material.dart';
import 'package:expense_trakker/expensetype.dart';

class Expenseitem extends StatelessWidget {
  const Expenseitem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text('Rs. ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(expense.formatteddate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

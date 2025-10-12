
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({super.key, required this.expense, required this.onDelete});

  final Expense expense;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(label: Text(expense.category.name.toUpperCase())),
                const SizedBox(width: 12),
                Text(expense.formattedDate),
              ],
            ),
            const SizedBox(height: 24),
            Text('\$' + expense.amount.toStringAsFixed(2), style: Theme.of(context).textTheme.headlineMedium),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete Expense'),
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

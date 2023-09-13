import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';


class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(context) {

    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(Icons.currency_rupee,
                  size: 16, color: Theme.of(context).iconTheme.color),
              Text(expense.amount.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              Row(children: [
                Icon(categoryIcons[expense.category],
                    color: Theme.of(context).iconTheme.color),
                const SizedBox(
                  width: 8,
                ),
                Text(expense.formattedDate,
                    style: Theme.of(context).textTheme.titleSmall),
              ]),
            ],
          )
        ],
      ),
    ));
  }
}

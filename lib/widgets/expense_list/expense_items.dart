import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expns_chart_blueprint.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(228, 0, 0, 0)),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('₹${expense.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(228, 0, 0, 0))),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category],
                          color: const Color.fromARGB(228, 0, 0, 0)),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(expense.formattedDate,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(228, 0, 0, 0)))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

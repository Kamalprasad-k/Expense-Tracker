import 'package:expense_tracker/widgets/expense_list/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expns_chart_blueprint.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: const Color.fromARGB(255, 255, 120, 120),
            margin: const EdgeInsets.symmetric(vertical: 6),
          ),
          onDismissed: (direaction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index])),
    );
  }
}


import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expns_chart_blueprint.dart';


class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
 
List<Expense> addedExpenses = [];

  void getExpenseAddingOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => AddNewExpense(
              addExpense: addNewExpense,
            ));
  }

  void addNewExpense(Expense expense) {
    setState(() {
      addedExpenses.add(expense);
    
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = addedExpenses.indexOf(expense);
    setState(() {
      addedExpenses.remove(expense);
    
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Expense Deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                addedExpenses.insert(expenseIndex, expense);
              
              });
            }),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent =
        const Center(child: Text('No expenses found! Add some...'));

    if (addedExpenses.isNotEmpty) {
      mainContent = ExpenseList(
          expenses: addedExpenses, onRemoveExpense: removeExpense);
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              onPressed: getExpenseAddingOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Chart(expenses: addedExpenses),
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(child: Chart(expenses: addedExpenses)),
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(child: mainContent),
                ],
              ));
  }
}

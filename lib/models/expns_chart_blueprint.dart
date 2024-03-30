import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  food,
  transport,
  rent,
  utilities,
  shopping,
  travel,
  entertainment,
  hobbies,
  loanRepayments,
  invest
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.transport: Icons.train,
  Category.rent: Icons.home,
  Category.utilities: Icons.build,
  Category.shopping: Icons.shopping_cart,
  Category.travel: Icons.flight_takeoff,
  Category.entertainment: Icons.movie,
  Category.hobbies: Icons.palette,
  Category.loanRepayments: Icons.payment,
  Category.invest: Icons.trending_up,
};

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.category,
      required this.date})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseCandle {
  ExpenseCandle({required this.category, required this.expenses});

  ExpenseCandle.toCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final List<Expense> expenses;
  final Category category;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

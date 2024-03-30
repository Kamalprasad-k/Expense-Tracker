import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expns_chart_blueprint.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseCandle> get candles {
    return [
      ExpenseCandle.toCategory(expenses, Category.food),
      ExpenseCandle.toCategory(expenses, Category.transport),
      ExpenseCandle.toCategory(expenses, Category.rent),
      ExpenseCandle.toCategory(expenses, Category.utilities),
      ExpenseCandle.toCategory(expenses, Category.shopping),
      ExpenseCandle.toCategory(expenses, Category.travel),
      ExpenseCandle.toCategory(expenses, Category.entertainment),
      ExpenseCandle.toCategory(expenses, Category.hobbies),
      ExpenseCandle.toCategory(expenses, Category.loanRepayments),
      ExpenseCandle.toCategory(expenses, Category.invest)
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final candle in candles) {
      if (candle.totalExpenses > maxTotalExpense) {
        maxTotalExpense = candle.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final candle in candles) // alternative to map()
                  ChartBar(
                    fill: candle.totalExpenses == 0
                        ? 0
                        : candle.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: candles
                .map(
                  (candle) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[candle.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

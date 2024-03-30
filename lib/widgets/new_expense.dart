import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expns_chart_blueprint.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final textEditingController = TextEditingController();
  final amountEditingController = TextEditingController();
  DateTime? selectedDate;
  Category selectedValue = Category.food;

  void datePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      selectedDate = pickedDate;
    });
  }

  void saveExpense() {
    final enteredAmount = double.tryParse(amountEditingController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;

    if (textEditingController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    widget.addExpense(
      Expense(
        title: textEditingController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedValue,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    amountEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardbottom = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardbottom + 16),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: textEditingController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      controller: amountEditingController,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefixText: '₹',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(
                                  selectedDate!,
                                ),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(width: 2),
                        IconButton(
                          onPressed: datePicker,
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  DropdownButton(
                    dropdownColor: const Color.fromARGB(244, 255, 255, 255),
                    value: selectedValue,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: saveExpense,
                    child: const Text('Save Expense'),
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

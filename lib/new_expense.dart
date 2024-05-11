import 'package:expense_trakker/expensetype.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddexpense});
  final void Function(Expense expense) onAddexpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selecteddate;
  Category _selectedCategory = Category.leisure;

  void presentdatepick() async {
    final now = DateTime.now();
    final firStdate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firStdate,
      lastDate: now,
    );

    setState(() {
      selecteddate = pickedDate;
    });
  }

  void _submitData() {
    final enteredamount = double.tryParse(amountController.text);
    final amountisinvalid = enteredamount == null || enteredamount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountisinvalid ||
        selecteddate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input!!'),
                content: const Text(
                    "Please make sure a valid Title, Amount, Date and Category was entered."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('okay'))
                ],
              ));
      return;
    }

    widget.onAddexpense(Expense(
        name: titleController.text,
        amount: enteredamount,
        date: selecteddate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text("Title")),
                      )),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "Rs. ",
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                selecteddate == null
                                    ? "Selected Date"
                                    : formatter.format(selecteddate!),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            IconButton(
                                onPressed: presentdatepick,
                                icon: const Icon(Icons.calendar_month_outlined))
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "Rs. ",
                            label: Text("Amount"),
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
                                selecteddate == null
                                    ? "Selected Date"
                                    : formatter.format(selecteddate!),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            IconButton(
                                onPressed: presentdatepick,
                                icon: const Icon(Icons.calendar_month_outlined))
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancle")),
                      ElevatedButton(
                          onPressed: () {
                            _submitData();
                          },
                          child: const Text("Save Expense"))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancle")),
                      ElevatedButton(
                          onPressed: () {
                            _submitData();
                          },
                          child: const Text("Save Expense"))
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}

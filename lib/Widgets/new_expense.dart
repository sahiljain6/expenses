import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _datePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2, now.month, now.day),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = (enteredAmount == null || enteredAmount <= 0);

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("INVALID!",
                    style: Theme.of(context).textTheme.titleSmall),
                content: Text('Please fill the full detail.',
                    style: Theme.of(context).textTheme.titleSmall),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('OKAY'))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
                child: Column(
                  children: [
                    if (width >= 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                                maxLength: 50,
                                decoration: InputDecoration(
                                    label: Text('Title',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall)),
                                controller: _titleController,
                                cursorColor: Colors.red,
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  label: Text('Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  prefixIcon: Icon(
                                    Icons.currency_rupee,
                                    size: 16,
                                    color: Theme.of(context).iconTheme.color,
                                  )),
                              keyboardType: TextInputType.number,
                              controller: _amountController,
                              cursorColor: Colors.red,
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                          ),
                        ],
                      )
                    else
                      TextField(
                          maxLength: 50,
                          decoration: InputDecoration(
                              label: Text('Title',
                                  style:
                                      Theme.of(context).textTheme.titleSmall)),
                          controller: _titleController,
                          cursorColor: Colors.red,
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black)),
                    if(width>=600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,children: [ DropdownButton(
                          style: Theme.of(context).textTheme.titleSmall,
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                        const Spacer(flex: 4,),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    _selectedDate == null
                                        ? 'Enter Date'
                                        : formatter.format(_selectedDate!),
                                    style:
                                    Theme.of(context).textTheme.titleSmall),
                                IconButton(
                                  onPressed: _datePicker,
                                  icon: const Icon(Icons.calendar_month),
                                ),
                              ]),
                        )
                      ],

                      )
                    else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                label: Text('Amount',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                prefixIcon: Icon(
                                  Icons.currency_rupee,
                                  size: 16,
                                  color: Theme.of(context).iconTheme.color,
                                )),
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            cursorColor: Colors.red,
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        const SizedBox(
                          width: 48,
                        ),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    _selectedDate == null
                                        ? 'Enter Date'
                                        : formatter.format(_selectedDate!),
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                IconButton(
                                  onPressed: _datePicker,
                                  icon: const Icon(Icons.calendar_month),
                                ),
                              ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    if(width>=600)
                      Row(children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),],)
                      else
                    Row(
                      children: [
                        DropdownButton(
                            style: Theme.of(context).textTheme.titleSmall,
                            value: _selectedCategory,
                            items: Category.values
                                .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase())))
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        const SizedBox(width: 108),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    )
                  ],
                )),
          ));
    });
  }
}

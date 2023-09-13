import 'package:expense_tracker/Widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:expense_tracker/widgets/charts/chart.dart';
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Travelling',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.travel ),
    Expense(
        title: 'Cinema',
        amount: 56.00,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void addExpense() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _insertExpense,
            ));
  }

  void _insertExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(

              duration: const Duration(seconds: 3),
              content: const Text('Expense Deleted'),
              action:SnackBarAction(
                  label:'Undo' ,
                  onPressed: (){
                    setState(() {
                      _registeredExpenses.insert(expenseIndex,expense);
                    });
                  })));

    });
  }

  @override
  Widget build(context) {
    final width=MediaQuery.of(context).size.width;


    Widget mainContent= Center(child: Text('No expenses found. Start Adding some!',style: Theme.of(context).textTheme.titleSmall),);
    if(_registeredExpenses.isNotEmpty)
      {
        mainContent=ExpensesList(
          expenses: _registeredExpenses,
          onRemoveExpense: _removeExpense,
        );
      }
    return Scaffold(
            appBar: AppBar(title: const Text('Expenses Tracker'),
                actions: [
          IconButton(
              onPressed: addExpense,
              icon: const Icon(Icons.add_circle)),
        ]),
        body: (width< 600) ?Column(
          children: [
            Chart(expenses:_registeredExpenses),

            Expanded(
                child:mainContent
            ) ],
        ):Row(children: [
          Expanded(child: Chart(expenses:_registeredExpenses)),
        Expanded(child:mainContent)]));
  }
}

import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/services/expense_storage.dart';
import 'package:expense_tracker/widgets/expense_details.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  void initState() {
    super.initState();
    ExpenseStorage.loadAll().then((items) {
      if (items.isNotEmpty) {
        setState(() {
          _registeredExpenses
            ..clear()
            ..addAll(items);
        });
      }
    });
  }

  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course',
    amount: 19.99,
    date: DateTime.now(),
    category: Category.work,
    rating: 4,
  ),
    Expense(title: 'Cinema',
    amount: 15.69,
    date: DateTime.now(),
    category: Category.leisure,
    rating: 3,
  ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  
  void _openDetails(Expense expense) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExpenseDetails(
          expense: expense,
          onDelete: () => _removeExpense(expense),
        ),
      ),
    );
  }
void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    ExpenseStorage.saveAll(_registeredExpenses);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    ExpenseStorage.saveAll(_registeredExpenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
        onTapExpense: _openDetails,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            ) 
          : Row(children: [
              Expanded(
                child: Chart(expenses: _registeredExpenses),
              ),
              Expanded(
                child: mainContent,
              ),
            ]),
    );
  }
}
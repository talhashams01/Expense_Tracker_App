import 'package:flutter/material.dart';
import 'package:flutter_udemy_section5/models/expense.dart';
import 'package:flutter_udemy_section5/widgets/expenses_list/expense_item.dart';
//import 'package:flutter_udemy_section5/widgets/expenses.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenses.length,
    itemBuilder: ((context, index) => Dismissible(key: ValueKey(expenses[index]),
    //background: Container(color: Theme.of(context).colorScheme.error),
    background: Container(color: Colors.red.withOpacity(0.90),
    //margin: EdgeInsets.symmetric(horizontal: 16),
    ),
    onDismissed: (direction){
      onRemoveExpense(expenses[index]);
    },
     child: ExpenseItem(expenses[index]),) 
    ));
  }
}
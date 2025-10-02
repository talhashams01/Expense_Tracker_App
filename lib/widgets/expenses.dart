import 'package:flutter/material.dart';
import 'package:flutter_udemy_section5/models/expense.dart';
import 'package:flutter_udemy_section5/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_udemy_section5/widgets/new_expense.dart';
import 'package:flutter_udemy_section5/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key}); //constructor function

  @override
  State<Expenses> createState() => _ExpensesState();
 
}

class _ExpensesState extends State<Expenses> {
  
 final List<Expense> _registeredExpenses =[
  Expense(
    title: 'Flutter Course',
    amount: 19.99,
    date: DateTime.now(),
    //category: Category(category.work as List<String>)
    category: Category.work,
   
    ),
    Expense(
    title: 'Cinema',
    amount: 15.69,
    date: DateTime.now(),
    //category: Category(category.leisure as List<String>)
    category: Category.leisure,
    ),
 ];

 void _openAddExpenseOverlay(){
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    context:  context ,
   builder: (ctx) =>  NewExpense(onAddExpense: _addExpense,),
    );
 }

  void _addExpense(Expense expense){
    setState(() {
       _registeredExpenses.add(expense);
    });
   }

   void _removeExpense(Expense expense){
    final expenseindex = _registeredExpenses.indexOf(expense);
        setState(() {
          _registeredExpenses.remove(expense);
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Expense Deleted'),
          action: SnackBarAction(label: 'Undo', onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseindex, expense);
            });
          }),
          )); //use to show a message when delete something
   }
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
      // print(MediaQuery.of(context).size.height);

    Widget mainContent = Center(child: 
    Text('No expenses found. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty){
      mainContent =  ExpensesList(expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(//backgroundColor: Colors.green,
        title: Text('Flutter Expense Tracker',),
        actions: [
        IconButton(onPressed: _openAddExpenseOverlay,
         icon: Icon(Icons.add))
      ],),
      body: width < 600 ? Column(children:  [
        Chart(expanses: _registeredExpenses, expenses: const[]),
        Expanded(
          child: mainContent, 
          ),
      ],) : Row(children: [
         Expanded(child: Chart(expanses: _registeredExpenses, expenses: const[])),
        Expanded(
          child: mainContent, 
          ),
      ],),
    );
  }
}
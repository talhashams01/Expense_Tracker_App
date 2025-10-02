//import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_section5/models/expense.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense; 

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

    // var _enteredTitle = '';
    // void _onChanged(String inputValue){
    //   _enteredTitle = inputValue;
    // }
    final _titlecontroller = TextEditingController();
    final _amountcontroller = TextEditingController();
     DateTime? _selectedDate;
    Category _selectedCategory = Category.leisure; // show initial category

   void _datepicker() async {
      final now = DateTime.now();
      final firstdate = DateTime(now.year - 1, now.month , now.day);
      //final lastdate = DateTime.now();

     final pickedDate =  await showDatePicker(context: context,
        initialDate: now,
         firstDate: firstdate, 
         lastDate: now,
         ); 
         setState(() {
           _selectedDate = pickedDate;
         });
    }


    void _submitExpenseData(){
      final enteredAmount = double.parse(_amountcontroller.text);
      final amountIsInvalid = enteredAmount == false || enteredAmount <= 0;
      if(_titlecontroller.text.trim().isEmpty ||
       amountIsInvalid ||
       _selectedDate == null) {
        // showCupertinoDialog(context: context, builder: (context) =>CupertinoAlertDialog(
        //   title: Text('Invalid Input'),
        //   content: Text('plz make sure a valid title, amount, date and category was entered.'),
        //   actions: [
        //     TextButton(onPressed: (){Navigator.pop(context);},
        //      child: Text('Okay'))
        //   ],
        // ));

         showDialog(context: context, builder: (context) =>AlertDialog(
           title: Text('Invalid Input'),
           content: Text('plz make sure a valid title, amount, date and category was entered.'),
           actions: [
             TextButton(onPressed: (){Navigator.pop(context);},
              child: Text('Okay'))
           ],
         ));
        return;
      }
      widget.onAddExpense(Expense(
      title: _titlecontroller.text,
       amount: enteredAmount, 
       date: _selectedDate !, 
       category: _selectedCategory,
       ));
       Navigator.pop(context);
    }
    
    @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }
    
   
  @override
  Widget build(BuildContext context) {
 
  final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
  
  return LayoutBuilder(builder: (context, constraints) {
   // print(constraints.minWidth);
    //print(constraints.maxWidth);
    //print(constraints.minHeight);
    //print(constraints.maxHeight);
    final width = constraints.maxWidth;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,48,20, keyboardSpace + 16),
          child: Column(
            children: [
              if(width >=600) // important: no curly braces
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Expanded(
                   child: TextField(
                      controller: _titlecontroller, // responsible for this TextField
                     maxLength: 50,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(label: Text('Title')),
                                 ),
                 ),
              SizedBox(width: 20),
              Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),

              ])
              else
              TextField(
               // onChanged: _enteredTitle, we donot need this anymore bcz we add _texteditingcontroller instead of it
               controller: _titlecontroller, // responsible for this TextField
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(label: Text('Title')),
              ),
              if(width >=600)
              Row(children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
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
                    },
                  ),
                   Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _datepicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ],
                    ),
                  ),

              ])
              else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _datepicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if(width>=600)
              Row(children: [
                 const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
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
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  });

    
  }
}
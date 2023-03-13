// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  // const NewTranslation({ Key? key }) : super(key: key);

  final Function addTx;

  NewTransaction(this.addTx);
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  // used for storing string values from user input
  final _amountController = TextEditingController();
  // constructor for adding new transactions

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; // this will stop the functions from executing if no inputs are entered
    }

// with widget. you can acces the properties and methods of a widget class inside a state class
    widget.addTx(
      enteredTitle, // returns the title in the controller
      enteredAmount, // returns the amount in the controller
      _selectedDate, // returns the selected date
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) => {
          if (pickedDate == null)
            {
              // return
              // this will return in the anonymous function and not continue with any other code.
              print("...")
            }
          else
            {
              setState(() {
                _selectedDate = pickedDate;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                10.0, // viewInsets gives us information about anything that's lapping into our view and typically that's the soft keyboard
            // the bottom keyword tells us how much space is occupied by the keyboard
            left: 10.0,
            right: 10,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // CupertinoTextField(placeholder: ,), this is for IOS
                TextField(
                  // text input box
                  decoration: InputDecoration(labelText: "Title"),
                  controller:
                      _titleController, // stores the title in the controller from user input
                  onSubmitted: (_) =>
                      _submitData(), // I have an argument here (_)
                  // but I am not going to use it, the underscore indicates that I don't use it
                ),
                TextField(
                  // text input box
                  decoration: InputDecoration(labelText: "Amount"),
                  controller:
                      _amountController, // stores the amount in the controller from user input
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      _submitData(), // I have an argument here (_)
                  // but I am not going to use it, the underscore indicates that I don't use it
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? "No Date Chosen!"
                              : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                        ),
                      ),
                      AdaptiveFlatButton("Choose Date", _presentDatePicker) // by doing this it reduces code duplication
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text("Add Transaction"),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitData,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

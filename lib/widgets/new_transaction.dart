// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  // const NewTranslation({ Key? key }) : super(key: key);

  final Function addTx;

  NewTransaction(this.addTx);
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  // used for storing string values from user input
  final amountController = TextEditingController();
  // constructor for adding new transactions
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; // this will stop the functions from executing if no inputs are entered
    }

// with widget. you can acces the properties and methods of a widget class inside a state class
    widget.addTx(
      enteredTitle, // returns the title in the controller
      enteredAmount, // returns the amount in the controller
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                // text input box
                decoration: InputDecoration(labelText: "Title"),
                controller:
                    titleController, // stores the title in the controller from user input
                onSubmitted: (_) => submitData(), // I have an argument here (_)
                // but I am not going to use it, the underscore indicates that I don't use it
              ),
              TextField(
                // text input box
                decoration: InputDecoration(labelText: "Amount"),
                controller:
                    amountController, // stores the amount in the controller from user input
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(), // I have an argument here (_)
                // but I am not going to use it, the underscore indicates that I don't use it
              ),
              FlatButton(
                child: Text("Add Transaction"),
                textColor: Colors.purple,
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}

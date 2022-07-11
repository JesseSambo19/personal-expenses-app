// import 'dart:html';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,
      this.deleteTx); // constructor which takes the list of transactions

  @override
  Widget build(BuildContext context) {
    return Container(
      // for specifying the exact height of the ListView
      height: MediaQuery.of(context).size.height /
          1.5, // MediaQuery.of(context).size.height / 2
      // almost remaining whole page = 300 remaining whole page = 450
      child: transactions.isEmpty
          ? Column(
              children: [
                Text("No transactions added yet!",
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset("assets/images/waiting.png",
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              // it's a column which is scrollable by default
              // alternative to nesting a column under a SingleChildScrollView widget
              // ListView(children: []) is less efficient than the ListView.builder,
              //because it may affect the performance of the app if the list is long.
              //The elements of the list on a ListView(children: []) will still be rendered
              //even though it's not visible while ListView.builder() will not be rendered hence the app will have a much better performance
              // this will return the list of transactions
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text("N\$${transactions[index].amount}"),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index]
                          .id), // wrap this in an anonymous function so that we pass a reference to this function, to this anonymous function
                      // and then when this anonymous function is executed in there, we have our own function
                      // we call now pass our argument
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

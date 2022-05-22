import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(
      this.transactions); // constructor which takes the list of transactions

  @override
  Widget build(BuildContext context) {
    return Container(
      // for specifying the exact height of the ListView
      height: MediaQuery.of(context).size.height / 2, // 300
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .primaryColor, // use the color of the global theme of the app
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "N\$${transactions[index].amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context)
                                .primaryColor, // use the color of the global theme of the app
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1, // custom textTheme
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

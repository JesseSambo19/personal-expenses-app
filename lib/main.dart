// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // // in order to be able to use SystemChrome, this needs to be added before the code
  // WidgetsFlutterBinding.ensureInitialized();
  // // used to set system wide settings for an application
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        // global color theme for the app theme
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // errorColor: Colors.red,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
            // custom textTheme it will only affect the titles for the expenses
            subtitle1: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.white,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                // custom textTheme it will only affect the title in the appBar
                subtitle1: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Weekly Groceries",
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

// function for adding new transactions
  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions
          .add(newTx); // it will refresh the ui when a new transaction is added
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      // modal for adding new transactions
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(
        context); // this is good practice because you don't recreate that object and tap into it
    //  and tap into a new object all the time which simply costs more performance and can lead to unnecessary re-render cycles,
    // instead you set up one connection, get the media query data once and store that in one object and you reuse that object throughout your build
    // method here which is more efficient
    // if different media query is used create another variable and store it inside and reuse where applicable
    final isLandscape = mediaQuery.orientation ==
        Orientation.landscape; // checks if the device is in landscape mode
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ))
        : AppBar(
            // this will check for either ios or android platform and render an appbar designed for each platform
            // I specified the data type because for some reason the CupertinoNavigationBar()
            // doesn't tell dart that it has the preferredsize widget even though it has
            title: Text(
              'Personal Expenses',
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          );

    final txListWidget = Container(
      // stores a widget code in a variable for reusability
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      // this makes sure that everything is positioned  within the boundaries or moved down a bit, moved up a bit
      // so that we respect these reserved areas on the screen
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment
          //     .spaceAround, //can be used to align the content in columns and rows
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if ((isLandscape))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1, // this will make an error go away when on landscape mode using an IOS device
                  ),
                  Switch.adaptive(
                    //  the adaptive constructor is used to adjust the design of the switch on both Android and IOS
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart, // this changes the value of the chart
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                        // sets the value of the chart when clicking on the switch
                      });
                    },
                  ),
                ],
              ),
            // if the device is not in landscape mode then show the portrait mode options
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            // if the device is not in landscape mode then show the portrait mode options
            if (!isLandscape) txListWidget,
            // if the device is in landscape mode then show the chart switch and relative image size
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget
            // returns both the textfields and list of transactions
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform
                    .isIOS // it's a dart boolean getter and it's used to check for variety of platforms. In this case it checks if the plaform is IOS.
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}

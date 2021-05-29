import 'package:basic_expense_planner/widgets/chart.dart';
import 'package:basic_expense_planner/widgets/new_transaction.dart';
import 'package:basic_expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Open Sans',
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transaction> transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Grocery',
    //   amount: 220.5,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Buy Shoes',
    //   amount: 260,
    //   date: DateTime.now(),
    // )
  ];

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    if (txAmount != null) {
      Transaction transaction = Transaction(
        title: txTitle,
        amount: txAmount,
        date: txDate,
        id: DateTime.now().toString(),
      );

      print(transaction);
      setState(() {
        transactions.add(transaction);
      });
    }
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    final lastDate = DateTime.now().subtract(Duration(days: 7));
    return transactions
        .where((transaction) => transaction.date.isAfter(lastDate))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: [
          IconButton(
            onPressed: () => showAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(_recentTransactions),
            TransactionList(transactions, _deleteTransaction),
            // NewTransaction(_addTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

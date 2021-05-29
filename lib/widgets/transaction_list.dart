import 'package:basic_expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.6,
      child: (transactions.length == 0)
          ? Image.asset('./assets/images/nodata.png')
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) => Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(transactions[index].date)
                            .toString(),
                      ),
                      trailing: MediaQuery.of(context).size.width > 420
                          ? TextButton.icon(
                              onPressed: () =>
                                  {_deleteTransaction(transactions[index].id)},
                              icon: Icon(Icons.delete),

                              // color: Theme.of(context).errorColor,
                              label: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: () =>
                                  {_deleteTransaction(transactions[index].id)},
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                            ),
                    ),
                  )),
    );
  }
}

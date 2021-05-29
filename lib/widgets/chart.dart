import 'package:basic_expense_planner/models/transaction.dart';
import 'package:basic_expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupTransactionValues {
    print(_recentTransactions);

    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0;

        for (var i = 0; i < _recentTransactions.length; i++) {
          if (_recentTransactions[i].date.day == weekDay.day &&
              _recentTransactions[i].date.month == weekDay.month &&
              _recentTransactions[i].date.year == weekDay.year) {
            totalSum += _recentTransactions[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return _groupTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_groupTransactionValues);
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _groupTransactionValues
                .map((data) => Flexible(
                      fit: FlexFit.loose,
                      child: ChartBar(
                        label: data['day'].toString(),
                        spendingAmount: double.parse(data['amount'].toString()),
                        spendingPctOfTotal: totalSpending == 0.0
                            ? 0
                            : double.parse(data['amount'].toString()) /
                                totalSpending,
                      ),
                    ))
                .toList()),
      ),
    );
  }
}

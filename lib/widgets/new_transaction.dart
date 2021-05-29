import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            onSubmitted: (_) => _submitData(),
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // hintText: 'Enter the Title',
                labelText: 'Title'),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // hintText: 'Enter the Amount',
                labelText: 'Amount'),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(date == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(date!)}'),
                ),
                TextButton(
                  onPressed: () => _presentDatePicker(context),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: Text(
              'Add Transaction',
            ),
          )
        ],
      ),
    ));
  }

  void _presentDatePicker(BuildContext ctx) async {
    DateTime? selectedDate = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        date = selectedDate;
      });
    }
  }

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    print(enteredTitle);
    print(enteredAmount);

    if (enteredTitle == '' || enteredAmount <= 0 || date == null) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      date,
    );

    Navigator.of(context).pop();
  }
}

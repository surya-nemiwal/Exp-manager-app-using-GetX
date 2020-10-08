import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime datePicked;
  final amountController = TextEditingController();

  void callback() {
    String title = titleController.text;
    if (amountController.text == null || title == null || datePicked == null) {
      return;
    }
    double amount = double.parse(amountController.text);
    print(title);
    print(amount);
    print(datePicked);
    TransactionController.to.addRecord(title: title, amount: amount, date: datePicked);
    Get.back();
  }

  void openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (value) => setState(() => datePicked = value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300 ,
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              // textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Price"),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Row(children: <Widget>[
              Text(datePicked == null ? 'No Date yet!' : 'date is: ${DateFormat.yMd().format(datePicked)}'),
              FlatButton(
                textColor: Get.theme.primaryColor,
                child: Text("Add Date"),
                onPressed: openDatePicker,
              ),
            ]),
            RaisedButton(
              child: Text(
                'Add transaction',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: callback,
            ),
          ],
        ),
      ),
    );
  }
}

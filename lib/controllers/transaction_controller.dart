import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Transcation.dart';
import '../widgets/new_transaction.dart';

class TransactionController extends GetxController {
  var transactionList = List<Transaction>().obs;
  RxBool showChart = true.obs;

  static TransactionController get to => Get.find();

  void toggleShowChart(val) {
    showChart.value = val;
  }

  List<Transaction> get getTransactionList => transactionList.toList();

  void deleteRecord(id) {
    // print(transactionList.toList());
    transactionList.removeWhere((element) => element.id == id);
    // transactionList.removeWhere((element) => element.id == id);
    // print(transactionList.toList());
  }

  List<Transaction> get resentTransactions {
    DateTime currentdate = DateTime.now().subtract(
      Duration(
        days: 7,
      ),
    );
    return transactionList
        .where(
          (transaction) => transaction.date.isAfter(currentdate),
        )
        .toList();
  }

  void addRecord({String title, double amount, DateTime date}) {
    // print('in addrecord function $title ,$amount ,$date');
    // print(transactionList.toList());
    transactionList.add(
      Transaction(
        name: title,
        price: amount,
        date: date,
        id: date.toString(),
      ),
    );
    // print(transactionList.toList());
  }

  void startAddNewTransaction(ctx) {
    // showModalBottomSheet<void>(
    //     context: ctx,
    //     builder: (BuildContext bCtx) {
    //       return NewTransaction(addRecord);
    //     });
    Get.bottomSheet(
      NewTransaction(),
      backgroundColor: Colors.white,
    );
  }
}

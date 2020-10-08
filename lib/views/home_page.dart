import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';
import '../widgets/transaction_list.dart';
import '../widgets/chart.dart';

class HomePage extends StatelessWidget {
  final transactionController = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    final isLandScape = context.isLandscape;
    final appBar = AppBar(
      title: Text("Expense Manager"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => transactionController.startAddNewTransaction(context),
        )
      ],
    );

    final txListWidget = Container(
      height: (context.height - appBar.preferredSize.height - context.mediaQueryPadding.top) * 0.7,
      width: double.infinity,
      child: TransactionList(),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show Chart'),
                    Switch(
                      value: transactionController.showChart.value,
                      onChanged: (val) => transactionController.toggleShowChart(val),
                    ),
                  ],
                ),
              if (isLandScape)
                if (transactionController.showChart.value)
                  Container(
                    height: (context.height - appBar.preferredSize.height - context.mediaQueryPadding.top) * 0.7,
                    child: Obx(
                      () => Chart(transactionController.resentTransactions),
                    ),
                  ),
              if (isLandScape) if (!transactionController.showChart.value) txListWidget,
              if (!isLandScape)
                Container(
                  height: (context.height - appBar.preferredSize.height - context.mediaQueryPadding.top) * .3,
                  child: Obx(
                    () => Chart(transactionController.resentTransactions),
                  ),
                ),
              if (!isLandScape) txListWidget,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            transactionController.startAddNewTransaction(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

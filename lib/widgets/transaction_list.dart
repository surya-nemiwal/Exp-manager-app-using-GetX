import 'package:ExpManager/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class TransactionList extends StatelessWidget {
  // final transcationController = Get.find()
  // final List<Transaction> transactionList;
  // final Function deleteRecord;
  // TransactionList(this.transactionList, this.deleteRecord);
  // final transactionList = TransactionController.to.getTransactionList;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        // constraints: BoxConstraints.expand(),
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: TransactionController.to.transactionList.isEmpty
              ? Column(
                  children: <Widget>[
                    Text(
                      'No Transaction to display',
                      style: Get.textTheme.headline6,
                      // style: Theme.of(context).textTheme.headline6,
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/images/waithing.png',
                        // height: constrains.maxHeight*0.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: TransactionController.to.transactionList.length,
                  itemBuilder: (bCtx, index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Container(
                          width: 100,
                          height: 50,
                          //padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Get.theme.primaryColor,
                          ),
                          child: Center(
                              child: Text(
                            '₹${TransactionController.to.transactionList[index].price.toStringAsFixed(0)}',
                          )),
                        ),
                        title: Text(
                          TransactionController.to.transactionList[index].name,
                          style: Get.textTheme.headline6,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(TransactionController.to.transactionList[index].date),
                        ),
                        trailing: Get.width > 410
                            ? FlatButton.icon(
                                onPressed: () => TransactionController.to.deleteRecord(TransactionController.to.transactionList[index].id),
                                icon: Icon(Icons.delete),
                                label: Text('Delete Item'),
                                textColor: Colors.red,
                              )
                            : IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => TransactionController.to.deleteRecord(TransactionController.to.transactionList[index].id),
                                color: Get.theme.errorColor,
                              ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

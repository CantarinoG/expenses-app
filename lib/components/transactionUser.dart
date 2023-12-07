import 'package:expenses/components/transactionForm.dart';
import 'package:expenses/components/transactionList.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TransactionUser> {
  final _transactions = [
    Transaction(id: "0", title: "Luz", value: 147.38, date: DateTime.now()),
    Transaction(id: "1", title: "Agua", value: 30.15, date: DateTime.now()),
    Transaction(
        id: "2", title: "Internet", value: 109.99, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(transactions: _transactions),
        TransactionForm()
      ],
    );
  }
}

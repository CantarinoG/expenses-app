import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _transactions = [
    Transaction(id: "0", title: "Luz", value: 147.38, date: DateTime.now()),
    Transaction(id: "1", title: "Agua", value: 30.15, date: DateTime.now()),
    Transaction(
        id: "2", title: "Internet", value: 109.99, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Card(child: Text("Gráfico")),
            width: double.infinity,
          ),
          Column(
            children: _transactions.map((e) {
              return Card(
                child: Text(e.title),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:expenses/components/transactionUser.dart';
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
          TransactionUser()
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:expenses/components/transactionForm.dart';
import 'package:expenses/components/transactionList.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: HomePage(),
      theme: tema.copyWith(
          colorScheme: tema.colorScheme
              .copyWith(primary: Colors.purple, secondary: Colors.amber),
          textTheme: tema.textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodyMedium:
                  TextStyle(fontFamily: 'Quicksand', color: Colors.black))),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _transactions = [
    Transaction(id: "0", title: "Luz", value: 147.38, date: DateTime.now()),
    Transaction(id: "1", title: "Agua", value: 30.15, date: DateTime.now()),
    Transaction(
        id: "2", title: "Internet", value: 109.99, date: DateTime.now()),
  ];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _addTransaction(String title, double value) {
    final transaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());
    setState(() {
      _transactions.add(transaction);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Despesas Pessoais"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _openTransactionFormModal(context);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Card(child: Text("Gráfico")),
                width: double.infinity,
              ),
              TransactionList(transactions: _transactions),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openTransactionFormModal(context);
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

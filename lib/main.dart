import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transactionForm.dart';
import 'package:expenses/components/transactionList.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final transaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);
    setState(() {
      _transactions.add(transaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Despesas Pessoais"),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              },
              icon: Icon(_showChart ? Icons.list : Icons.bar_chart)),
        IconButton(
            onPressed: () {
              _openTransactionFormModal(context);
            },
            icon: Icon(Icons.add))
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (_showChart || !isLandscape)
                Container(
                    height: availableHeight * (isLandscape ? 0.7 : 0.3),
                    child: Chart(recentTransactions: _recentTransactions)),
              if (!_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 1 : 0.7),
                  child: TransactionList(
                    transactions: _transactions,
                    deleteFn: _deleteTransaction,
                  ),
                ),
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

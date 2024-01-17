import 'package:expenses/components/adaptativeButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value < 0) return;

    widget.onSubmit(title, value, _selectedDate);
    _titleController.text = "";
    _valueController.text = "";
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now(),
            initialDate: _selectedDate)
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: _valueController,
                decoration: InputDecoration(labelText: "Valor (R\$)"),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(DateFormat('d/M/y').format(_selectedDate)),
                    MaterialButton(
                        child: Text(
                          "Selecionar Data",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: _showDatePicker)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                      onPressed: _submitForm, label: "Nova Transação"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

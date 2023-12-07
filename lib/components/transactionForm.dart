import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: "Valor (R\$)"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    print(titleController.text);
                    print(valueController.text);
                    titleController.text = "";
                    valueController.text = "";
                  },
                  child: Text(
                    "Nova Transação",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(TransactionApp());
}

class TransactionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TransactionHomePage(),
    );
  }
}

class TransactionHomePage extends StatefulWidget {
  @override
  _TransactionHomePageState createState() => _TransactionHomePageState();
}

class _TransactionHomePageState extends State<TransactionHomePage> {
  final List<Map<String, dynamic>> _transactions = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addTransaction() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty || amount == null) return;

    setState(() {
      _transactions.add({
        'title': title,
        'amount': amount,
        'date': DateTime.now(),
      });
    });

    _titleController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addTransaction,
                  child: Text('Add Transaction'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, index) {
                final tx = _transactions[index];
                return Card(
                  child: ListTile(
                    title: Text(tx['title']),
                    subtitle: Text(tx['date'].toString()),
                    trailing: Text('\$${tx['amount']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


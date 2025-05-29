import 'package:flutter/material.dart';

void main() => runApp(AccountingApp());

class AccountingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accounting App Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _transactions = [];
  double _balance = 0;

  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addTransaction(bool isIncome) {
    final description = _descController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (description.isEmpty || amount <= 0) return;

    setState(() {
      _transactions.add({
        'desc': description,
        'amount': isIncome ? amount : -amount,
        'date': DateTime.now()
      });
      _balance += isIncome ? amount : -amount;
    });

    _descController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounting App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Balance: €${_balance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount (€)'),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _addTransaction(true),
                  child: Text('Add Income'),
                ),
                ElevatedButton(
                  onPressed: () => _addTransaction(false),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Add Expense'),
                ),
              ],
            ),
            Divider(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(_transactions[i]['desc']),
                  subtitle: Text(_transactions[i]['date'].toString()),
                  trailing: Text(
                    '${_transactions[i]['amount'] >= 0 ? '+' : ''}${_transactions[i]['amount'].toStringAsFixed(2)} €',
                    style: TextStyle(
                      color: _transactions[i]['amount'] >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

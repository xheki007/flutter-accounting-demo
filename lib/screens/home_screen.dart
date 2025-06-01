import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TransactionModel>> _futureTx;

  @override
  void initState() {
    super.initState();
    _futureTx = fetchTransactions();
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    final response = await Supabase.instance.client
        .from('transactions')
        .select('*')
        .order('date', ascending: false);

    return (response as List)
        .map((item) => TransactionModel.fromJson(item))
        .toList();
  }

  double getTotal(List<TransactionModel> tx, bool isIncome) {
    return tx
        .where((t) => t.isIncome == isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Finances'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: _futureTx,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final txs = snapshot.data ?? [];
          final totalIncome = getTotal(txs, true);
          final totalExpense = getTotal(txs, false);
          final balance = totalIncome - totalExpense;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text(
                          'Current Balance',
                          style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '€${balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoCard('Income', totalIncome, Colors.green[50]!, Colors.green),
                    _infoCard('Expenses', totalExpense, Colors.red[50]!, Colors.red),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ...txs.map(_txTile).toList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {
            _futureTx = fetchTransactions();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _infoCard(String label, double amount, Color bg, Color textColor) {
    return Card(
      color: bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 16, color: textColor)),
            const SizedBox(height: 6),
            Text(
              '€${amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _txTile(TransactionModel t) {
    return ListTile(
      leading: Icon(
        t.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
        color: t.isIncome ? Colors.green : Colors.red,
      ),
      title: Text(t.description),
      subtitle: Text(
        '${t.date.year}-${t.date.month.toString().padLeft(2, '0')}-${t.date.day.toString().padLeft(2, '0')}',
      ),
      trailing: Text(
        '${t.isIncome ? '+' : '-'}€${t.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: t.isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

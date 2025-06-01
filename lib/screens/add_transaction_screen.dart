import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit(bool isIncome) async {
    final desc = _descController.text.trim();
    final amt = double.tryParse(_amountController.text.trim()) ?? 0;

    if (desc.isEmpty || amt <= 0) return;
    setState(() => _isLoading = true);

    await Supabase.instance.client.from('transactions').insert({
      'description': desc,
      'amount': amt,
      'is_income': isIncome,
      'date': DateTime.now().toIso8601String(),
    });
    setState(() => _isLoading = false);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (€)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 26),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => _submit(true),
                      child: const Text('Add Income'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => _submit(false),
                      child: const Text('Add Expense'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

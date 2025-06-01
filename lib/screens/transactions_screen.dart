import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        "title": "Groceries",
        "amount": -55.00,
        "date": "2025-05-29",
        "type": "Expense"
      },
      {
        "title": "Salary",
        "amount": 2000.00,
        "date": "2025-05-28",
        "type": "Income"
      },
      {
        "title": "Coffee",
        "amount": -3.50,
        "date": "2025-05-28",
        "type": "Expense"
      },
      {
        "title": "Gift",
        "amount": 100.00,
        "date": "2025-05-27",
        "type": "Income"
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f9),
      appBar: AppBar(
        backgroundColor: const Color(0xff4338CA),
        elevation: 0,
        title: Text(
          "All Transactions",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          final isIncome = tx["type"] == "Income";
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.09),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundColor:
                isIncome ? Colors.green.shade50 : Colors.red.shade50,
                child: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? Colors.green : Colors.red,
                  size: 28,
                ),
              ),
              title: Text(
                tx["title"],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 18),
              ),
              subtitle: Text(
                tx["date"],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey),
              ),
              trailing: Text(
                "${isIncome ? "+" : "-"}€${tx["amount"].abs().toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  color: isIncome ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

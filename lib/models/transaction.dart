class TransactionModel {
  final int id;
  final String description;
  final double amount;
  final DateTime date;
  final bool isIncome;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      description: json['description'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      isIncome: json['is_income'],
    );
  }

  Map<String, dynamic> toJson() => {
    'description': description,
    'amount': amount,
    'date': date.toIso8601String(),
    'is_income': isIncome,
  };
}

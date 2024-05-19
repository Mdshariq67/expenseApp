class Expense {
  final int id;
  final double amount;
  final DateTime date;
  final String description;
  final String type;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
    required this.type,
  });

  // Method to create a copy of Expense with updated fields
  Expense copyWith({
    int? id,
    double? amount,
    DateTime? date,
    String? description,
    String? type,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }
}

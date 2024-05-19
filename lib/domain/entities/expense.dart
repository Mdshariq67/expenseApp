class Expense {
  final int id;
  final double amount;
  final DateTime date;
  final String description;
  final String type;

  Expense(
      {required this.id,
      required this.amount,
      required this.date,
      required this.description,
      required this.type});
}

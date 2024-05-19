import 'package:expenseapp/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required int id,
    required double amount,
    required DateTime date,
    required String description,
    required String type,
  }) : super(
          id: id,
          amount: amount,
          date: date,
          description: description,
          type: type,
        );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json['id'],
        amount: json['amount'],
        date: DateTime.parse(json['date']),
        description: json['description'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'date': date.toIso8601String(),
        'description': description,
        'type': type,
      };
}

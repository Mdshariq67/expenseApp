import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/domain/repositories/expense_repository.dart';

class UpdateExpense {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  Future<void> call(Expense expense) async {
    await repository.updateExpense(expense);
  }
}

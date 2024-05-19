import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/domain/repositories/expense_repository.dart';

class AddExpense {
  final ExpenseRepository repository;

  AddExpense(this.repository);

  Future<void> call(Expense expense) async {
    await repository.addExpense(expense);
  }
}

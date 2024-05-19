import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/domain/repositories/expense_repository.dart';

class GetExpenses {
  final ExpenseRepository repository;

  GetExpenses(this.repository);

  Future<List<Expense>> call() async {
    return await repository.getExpenses();
  }
}

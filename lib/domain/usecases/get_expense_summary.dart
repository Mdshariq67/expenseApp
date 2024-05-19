import 'package:expenseapp/domain/repositories/expense_repository.dart';

class GetExpenseSummary {
  final ExpenseRepository repository;

  GetExpenseSummary(this.repository);

  Future<Map<String, double>> call(DateTime startDate, DateTime endDate) async {
    return await repository.getExpenseSummary(startDate, endDate);
  }
}

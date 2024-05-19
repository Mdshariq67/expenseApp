import 'package:expenseapp/domain/entities/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);
  Future<List<Expense>> getExpenses();
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(int id);
  Future<Map<String, double>> getExpenseSummary(
      DateTime startDate, DateTime endDate);
}

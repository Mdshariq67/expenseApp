import 'package:expenseapp/data/datasources/local/expense_local_data_source.dart';
import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/domain/repositories/expense_repository.dart';
import '../models/expense_model.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<void> addExpense(Expense expense) async {
    await localDataSource.addExpense(ExpenseModel(
        id: expense.id,
        amount: expense.amount,
        date: expense.date,
        description: expense.description,
        type: expense.type));
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final expenseModels = await localDataSource.getExpenses();
    print("000000000${expenseModels[0].amount}");
    return expenseModels
        .map((model) => Expense(
            id: model.id,
            amount: model.amount,
            date: model.date,
            description: model.description,
            type: model.type))
        .toList();
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await localDataSource.updateExpense(ExpenseModel(
        id: expense.id,
        amount: expense.amount,
        date: expense.date,
        description: expense.description,
        type: expense.type));
  }

  @override
  Future<void> deleteExpense(int id) async {
    await localDataSource.deleteExpense(id);
  }

  @override
  Future<Map<String, double>> getExpenseSummary(
      DateTime startDate, DateTime endDate) async {
    final expenses = await localDataSource.getExpenses();
    final filteredExpenses = expenses
        .where((expense) =>
            expense.date.isAfter(startDate) && expense.date.isBefore(endDate))
        .toList();

    final summary = <String, double>{};
    for (var expense in filteredExpenses) {
      summary[expense.type] = (summary[expense.type] ?? 0) + expense.amount;
    }
    return summary;
  }
}

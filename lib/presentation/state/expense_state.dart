import 'package:flutter/foundation.dart';
import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/domain/usecases/add_expense.dart';
import 'package:expenseapp/domain/usecases/get_expenses.dart';
import 'package:expenseapp/domain/usecases/update_expense.dart';
import 'package:expenseapp/domain/usecases/delete_expense.dart';
import 'package:expenseapp/domain/usecases/get_expense_summary.dart';
import 'package:flutter/material.dart';

class ExpenseState extends ChangeNotifier {
  final AddExpense _addExpense;
  final GetExpenses _getExpenses;
  final UpdateExpense _updateExpense;
  final DeleteExpense _deleteExpense;
  final GetExpenseSummary _getExpenseSummary;

  ExpenseState(
    this._addExpense,
    this._getExpenses,
    this._updateExpense,
    this._deleteExpense,
    this._getExpenseSummary,
  );

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;
  DateTimeRange? _dateRange;
  DateTimeRange? get dateRange => _dateRange;

  Future<void> fetchExpenses() async {
    _expenses = await _getExpenses();
    notifyListeners();
  }

  Future<void> addNewExpense(Expense expense) async {
    await _addExpense(expense);
    await fetchExpenses();
  }

  Future<void> updateExistingExpense(Expense expense) async {
    await _updateExpense(expense);
    await fetchExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await _deleteExpense(id);
    await fetchExpenses();
  }

  Future<Map<String, double>> getExpenseSummary(
      DateTime startDate, DateTime endDate) async {
    final allExpenses = await _getExpenses();

    final filteredExpenses = allExpenses.where((expense) {
      return expense.date.isAfter(startDate) &&
          expense.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    final Map<String, double> summary = {};
    for (var expense in filteredExpenses) {
      if (summary.containsKey(expense.type)) {
        summary[expense.type] = summary[expense.type]! + expense.amount;
      } else {
        summary[expense.type] = expense.amount;
      }
    }

    return summary;
  }

  void updateDateRange(DateTimeRange newRange) {
    _dateRange = newRange;
    fetchExpenses();
  }
}

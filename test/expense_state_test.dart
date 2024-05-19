import 'package:flutter_test/flutter_test.dart';
import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/domain/repositories/expense_repository.dart';
import 'package:expenseapp/domain/usecases/add_expense.dart';
import 'package:expenseapp/domain/usecases/get_expenses.dart';
import 'package:expenseapp/domain/usecases/update_expense.dart';
import 'package:expenseapp/domain/usecases/delete_expense.dart';
import 'package:expenseapp/domain/usecases/get_expense_summary.dart';
import 'package:expenseapp/presentation/state/expense_state.dart';

class FakeExpenseRepository implements ExpenseRepository {
  List<Expense> expenses = [];

  @override
  Future<void> addExpense(Expense expense) async {
    expenses.add(expense);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    return expenses;
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    final index = expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      expenses[index] = expense;
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    expenses.removeWhere((e) => e.id == id);
  }

  @override
  Future<Map<String, double>> getExpenseSummary(
      DateTime startDate, DateTime endDate) async {
    return {'Food': 100.0};
  }
}

void main() {
  late ExpenseState expenseState;
  late FakeExpenseRepository fakeExpenseRepository;

  setUp(() {
    fakeExpenseRepository = FakeExpenseRepository();
    expenseState = ExpenseState(
      AddExpense(fakeExpenseRepository),
      GetExpenses(fakeExpenseRepository),
      UpdateExpense(fakeExpenseRepository),
      DeleteExpense(fakeExpenseRepository),
      GetExpenseSummary(fakeExpenseRepository),
    );
  });

  test('fetchExpenses should update expenses list', () async {
    // Arrange
    final expense = Expense(
      id: 1,
      amount: 100.0,
      date: DateTime.now(),
      description: 'Test Expense',
      type: 'Food',
    );
    fakeExpenseRepository.expenses = [expense];

    await expenseState.fetchExpenses();

    expect(expenseState.expenses, [expense]);
  });

  test('addNewExpense should add expense and update expenses list', () async {
    // Arrange
    final expense = Expense(
      id: 1,
      amount: 100.0,
      date: DateTime.now(),
      description: 'Test Expense',
      type: 'Food',
    );

    await expenseState.addNewExpense(expense);

    expect(fakeExpenseRepository.expenses, [expense]);
  });
}

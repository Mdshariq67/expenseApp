import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/domain/repositories/expense_repository.dart';
import 'package:expenseapp/domain/usecases/add_expense.dart';
import 'package:expenseapp/domain/usecases/get_expenses.dart';
import 'package:expenseapp/domain/usecases/update_expense.dart';
import 'package:expenseapp/domain/usecases/delete_expense.dart';
import 'package:expenseapp/domain/usecases/get_expense_summary.dart';
import 'package:expenseapp/presentation/state/expense_state.dart';
import 'expense_state_test.mocks.dart';

@GenerateMocks([ExpenseRepository])
void main() {
  late ExpenseState expenseState;
  late MockExpenseRepository mockExpenseRepository;
  late AddExpense addExpense;
  late GetExpenses getExpenses;
  late UpdateExpense updateExpense;
  late DeleteExpense deleteExpense;
  late GetExpenseSummary getExpenseSummary;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    addExpense = AddExpense(mockExpenseRepository);
    getExpenses = GetExpenses(mockExpenseRepository);
    updateExpense = UpdateExpense(mockExpenseRepository);
    deleteExpense = DeleteExpense(mockExpenseRepository);
    getExpenseSummary = GetExpenseSummary(mockExpenseRepository);
    expenseState = ExpenseState(addExpense, getExpenses, updateExpense,
        deleteExpense, getExpenseSummary);
  });

  group('ExpenseState', () {
    final expense = Expense(
      id: 1,
      amount: 100.0,
      date: DateTime.now(),
      description: 'Test Expense',
      type: 'Food',
    );

    test('fetchExpenses should update expenses list', () async {
      // Arrange
      when(mockExpenseRepository.getExpenses())
          .thenAnswer((_) async => [expense]);

      // Act
      await expenseState.fetchExpenses();

      // Assert
      expect(expenseState.expenses, [expense]);
      verify(mockExpenseRepository.getExpenses()).called(1);
      verifyNoMoreInteractions(mockExpenseRepository);
    });

    test('addNewExpense should add expense and update expenses list', () async {
      // Arrange
      when(mockExpenseRepository.addExpense(expense))
          .thenAnswer((_) async => Future.value());
      when(mockExpenseRepository.getExpenses())
          .thenAnswer((_) async => [expense]);

      // Act
      await expenseState.addNewExpense(expense);

      // Assert
      expect(expenseState.expenses, [expense]);
      verify(mockExpenseRepository.addExpense(expense)).called(1);
      verify(mockExpenseRepository.getExpenses()).called(1);
      verifyNoMoreInteractions(mockExpenseRepository);
    });

    test(
        'updateExistingExpense should update expense and refresh expenses list',
        () async {
      // Arrange
      when(mockExpenseRepository.updateExpense(expense))
          .thenAnswer((_) async => Future.value());
      when(mockExpenseRepository.getExpenses())
          .thenAnswer((_) async => [expense]);

      // Act
      await expenseState.updateExistingExpense(expense);

      // Assert
      expect(expenseState.expenses, [expense]);
      verify(mockExpenseRepository.updateExpense(expense)).called(1);
      verify(mockExpenseRepository.getExpenses()).called(1);
      verifyNoMoreInteractions(mockExpenseRepository);
    });

    test('deleteExpense should delete expense and refresh expenses list',
        () async {
      // Arrange
      when(mockExpenseRepository.deleteExpense(1))
          .thenAnswer((_) async => Future.value());
      when(mockExpenseRepository.getExpenses()).thenAnswer((_) async => []);

      // Act
      await expenseState.deleteExpense(1);

      // Assert
      expect(expenseState.expenses, []);
      verify(mockExpenseRepository.deleteExpense(1)).called(1);
      verify(mockExpenseRepository.getExpenses()).called(1);
      verifyNoMoreInteractions(mockExpenseRepository);
    });

    test('getExpenseSummary should return summary', () async {
      // Arrange
      final summary = {'Food': 100.0};
      when(mockExpenseRepository.getExpenseSummary(any, any))
          .thenAnswer((_) async => summary);

      // Act
      final result =
          await expenseState.getExpenseSummary(DateTime.now(), DateTime.now());

      // Assert
      expect(result, summary);
      verify(mockExpenseRepository.getExpenseSummary(any, any)).called(1);
      verifyNoMoreInteractions(mockExpenseRepository);
    });
  });
}

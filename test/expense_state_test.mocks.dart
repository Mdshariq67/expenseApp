// Mocks generated by Mockito 5.4.4 from annotations
// in expenseapp/test/expense_state_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:expenseapp/domain/entities/expense.dart' as _i4;
import 'package:expenseapp/domain/repositories/expense_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ExpenseRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockExpenseRepository extends _i1.Mock implements _i2.ExpenseRepository {
  MockExpenseRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> addExpense(_i4.Expense? expense) => (super.noSuchMethod(
        Invocation.method(
          #addExpense,
          [expense],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i4.Expense>> getExpenses() => (super.noSuchMethod(
        Invocation.method(
          #getExpenses,
          [],
        ),
        returnValue: _i3.Future<List<_i4.Expense>>.value(<_i4.Expense>[]),
      ) as _i3.Future<List<_i4.Expense>>);

  @override
  _i3.Future<void> updateExpense(_i4.Expense? expense) => (super.noSuchMethod(
        Invocation.method(
          #updateExpense,
          [expense],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteExpense(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteExpense,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<Map<String, double>> getExpenseSummary(
    DateTime? startDate,
    DateTime? endDate,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getExpenseSummary,
          [
            startDate,
            endDate,
          ],
        ),
        returnValue: _i3.Future<Map<String, double>>.value(<String, double>{}),
      ) as _i3.Future<Map<String, double>>);
}

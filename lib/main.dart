import 'package:expenseapp/presentation/pages/add_expense_page.dart';
import 'package:expenseapp/presentation/pages/edit_expense_page.dart';
import 'package:expenseapp/presentation/pages/expense_summary_page.dart';
import 'package:expenseapp/presentation/state/expense_state.dart';
import 'package:expenseapp/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/usecases/add_expense.dart';
import 'domain/usecases/get_expenses.dart';
import 'domain/usecases/update_expense.dart';
import 'domain/usecases/delete_expense.dart';
import 'domain/usecases/get_expense_summary.dart';
import 'data/repositories/expense_repository_impl.dart';
import 'data/datasources/local/expense_local_data_source.dart';
import 'presentation/pages/expense_list_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  final expenseLocalDataSource = ExpenseLocalDataSource.init();
  final expenseRepository = ExpenseRepositoryImpl(expenseLocalDataSource);
  await LocalNotifications.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ExpenseState(
            AddExpense(expenseRepository),
            GetExpenses(expenseRepository),
            UpdateExpense(expenseRepository),
            DeleteExpense(expenseRepository),
            GetExpenseSummary(expenseRepository),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ExpenseListPage(),
        '/add': (context) => const AddExpensePage(),
        '/edit': (context) => const EditExpensePage(),
        '/summary': (context) => const ExpenseSummaryPage(),
      },
    );
  }
}

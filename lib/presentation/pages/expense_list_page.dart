import 'package:expenseapp/presentation/state/expense_state.dart';
import 'package:expenseapp/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key});

  @override
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  @override
  void initState() {
    super.initState();
    LocalNotifications().scheduleDailyTenAMNotification();
    Provider.of<ExpenseState>(context, listen: false).fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () {
              Navigator.pushNamed(context, '/summary');
            },
          ),
        ],
      ),
      body: Consumer<ExpenseState>(
        builder: (context, expenseState, child) {
          if (expenseState.expenses.isEmpty) {
            return const Center(child: Text('No expenses found.'));
          }

          return ListView.builder(
            itemCount: expenseState.expenses.length,
            itemBuilder: (context, index) {
              final expense = expenseState.expenses[index];
              return ListTile(
                title: Text(expense.description),
                subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(expense.date.toIso8601String()),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await _showDeleteConfirmationDialog(
                            context, expenseState, expense.id);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/edit',
                    arguments: expense,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> _showDeleteConfirmationDialog(
    BuildContext context, ExpenseState expenseState, int id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Expense'),
        content: const Text('Are you sure you want to delete this expense?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () async {
              await expenseState.deleteExpense(id);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

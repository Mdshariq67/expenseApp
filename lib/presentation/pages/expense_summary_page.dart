import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenseapp/presentation/state/expense_state.dart';

class ExpenseSummaryPage extends StatefulWidget {
  const ExpenseSummaryPage({super.key});

  @override
  _ExpenseSummaryPageState createState() => _ExpenseSummaryPageState();
}

class _ExpenseSummaryPageState extends State<ExpenseSummaryPage> {
  final DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  final DateTime _endDate = DateTime.now();
  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    final expenseState = Provider.of<ExpenseState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Summary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () async {
              final DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                initialDateRange: _dateRange,
              );

              if (picked != null && picked != _dateRange) {
                setState(() {
                  _dateRange = picked;
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, double>>(
        future:
            expenseState.getExpenseSummary(_dateRange.start, _dateRange.end),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          }

          final summary = snapshot.data!;
          if (summary.isEmpty) {
            return const Center(
                child: Text('No expenses found for this period.'));
          }

          return ListView(
            children: summary.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                trailing: Text('\$${entry.value.toStringAsFixed(2)}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

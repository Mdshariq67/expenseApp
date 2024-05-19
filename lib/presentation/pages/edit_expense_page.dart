import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenseapp/domain/entities/expense.dart';
import 'package:expenseapp/presentation/state/expense_state.dart';

class EditExpensePage extends StatefulWidget {
  const EditExpensePage({super.key});

  @override
  _EditExpensePageState createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  late String _selectedType;

  final List<String> _expenseTypes = [
    'Food',
    'Transport',
    'Entertainment',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    final expense = ModalRoute.of(context)!.settings.arguments as Expense;
    _amountController.text = expense.amount.toString();
    _descriptionController.text = expense.description;
    _dateController.text = expense.date.toIso8601String();
    _selectedType = expense.type;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expense = ModalRoute.of(context)!.settings.arguments as Expense;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text = pickedDate.toIso8601String();
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: _expenseTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedExpense = Expense(
                      id: expense.id,
                      amount: double.parse(_amountController.text),
                      date: DateTime.parse(_dateController.text),
                      description: _descriptionController.text,
                      type: _selectedType,
                    );
                    Provider.of<ExpenseState>(context, listen: false)
                        .updateExistingExpense(updatedExpense);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

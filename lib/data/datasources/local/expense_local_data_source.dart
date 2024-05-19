import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../../models/expense_model.dart';

class ExpenseLocalDataSource {
  static final ExpenseLocalDataSource instance = ExpenseLocalDataSource.init();

  static Database? _database;

  ExpenseLocalDataSource.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE expenses ( 
  id $idType, 
  amount $doubleType,
  date $textType,
  description $textType,
  type $textType
  )
''');
  }

  Future<void> addExpense(ExpenseModel expense) async {
    final db = await instance.database;
    await db.insert('expenses', expense.toJson());
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final db = await instance.database;
    final result = await db.query('expenses');
    return result.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await instance.database;
    await db.update(
      'expenses',
      expense.toJson(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> deleteExpense(int id) async {
    final db = await instance.database;
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

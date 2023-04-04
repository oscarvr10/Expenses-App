import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expenses_model.dart';

class DBExpenses {
  static Database? _database;
  static final DBExpenses db = DBExpenses._();

  DBExpenses._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  initDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'ExpensesDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE Expenses (
              id INTEGER PRIMARY KEY, 
              link INTEGER, 
              year INTEGER, 
              month INTEGER,
              day INTEGER,
              comment TEXT,
              expense DOUBLE
            )''');
        await db.execute('''CREATE TABLE Entries (
              id INTEGER PRIMARY KEY,               
              year INTEGER, 
              month INTEGER,
              day INTEGER,
              comment TEXT,
              entries DOUBLE
            )''');
      },
    );
  }

  addNewExpense(ExpensesModel expense) async {
    final db = await database;
    final response = db.insert('Expenses', expense.toJson());

    return response;
  }

  Future<List<ExpensesModel>> getExpenseByDate(int month, int year) async {
    final db = await database;
    final response = await db.query('Expenses',
        where: 'month = ? and year = ?', whereArgs: [month, year]);

    List<ExpensesModel> eList = response.isNotEmpty
        ? response.map((e) => ExpensesModel.fromJson(e)).toList()
        : [];

    return eList;
  }

  Future<int> updateExpense(ExpensesModel expense) async {
    final db = await database;
    final response = db.update('Expenses', expense.toJson(),
        where: 'id = ?', whereArgs: [expense.id]);

    return response;
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    final response = db.delete('Expenses', where: 'id = ?', whereArgs: [id]);

    return response;
  }
}

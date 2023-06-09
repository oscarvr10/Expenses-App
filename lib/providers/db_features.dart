import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:exp_app/models/features_model.dart';

class DBFeatures {
  static Database? _database;
  static final DBFeatures db = DBFeatures._();

  DBFeatures._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  initDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'featureDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE Features (
              id INTEGER PRIMARY KEY, 
              category TEXT, 
              color TEXT, 
              icon TEXT
            )''');
      },
    );
  }

  addNewFeature(FeaturesModel feature) async {
    final db = await database;
    final response = db.insert('Features', feature.toJson());

    return response;
  }

  Future<List<FeaturesModel>> getAllFeatures() async {
    final db = await database;
    final response = await db.query('Features');

    List<FeaturesModel> fList = response.isNotEmpty
        ? response.map((e) => FeaturesModel.fromJson(e)).toList()
        : [];

    return fList;
  }

  Future<int> updateFeature(FeaturesModel feature) async {
    final db = await database;
    final response = db.update('Features', feature.toJson(),
        where: 'id = ?', whereArgs: [feature.id]);

    return response;
  }
}

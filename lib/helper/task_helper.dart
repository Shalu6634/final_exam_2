import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? _db;

  Future<Database> get database async => _db ?? await initDatabase();

  Future<Database> initDatabase() async {

    String path = await getDatabasesPath();
    final dbPath = join(path,'task.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql =
            '''CREATE TABLE task(id INTEGER AUTOINCREMENT,title TEXT,des TEXT,due TEXT,category TEXT);''';
        return await db.execute(sql);
      },
    );
    return _db!;
  }

  Future<dynamic> insertDatabase(String title,String des,String due,String category)
  async {
    Database? db = await database;
    String sql = '''INSERT INTO task(title,des,due,category) VALUES(?,?,?,?)''';
    List args = [title,des,due,category];
    await db.rawInsert(sql,args);
  }


  Future<List<Map<String, Object?>>> readDataFromTable()
  async {
    Database? db = await database;
    String sql = '''SELECT * FROM task''';
    return await db.rawQuery(sql);
  }
  Future<void> deleteData(int id)
  async {
    Database? db = await database;
    String sql = '''DELETE FROM task WHERE id = ?;''';
    List args = [id];
    await db.rawDelete(sql,args);
  }

  Future<void> updateData(String title,String des,String due,String category,int id)
  async {
    Database? db = await database;
    String sql='''UPDATE task SET title = ?,des= ?,due = ?,category = ? WHERE id = ?''';
    List args = [title,des,due,category,id];
    await db.rawInsert(sql,args);
  }
  Future<List<Map<String, Object?>>> searchData(String title)
  async {
    Database? db = await database;
    String sql = "SELECT * FROM task WHERE title LIKE '%$title%'";
    return await db.rawQuery(sql);
  }

}

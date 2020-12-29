import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sqlite.Database> database() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(dbPath, 'tasks.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_tasks(id TEXT PRIMARY KEY, taskName TEXT, isDone INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final myDb = await DbHelper.database();
    await myDb.insert(table, data,
        conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
  }

  static Future<void> update(Map<String, Object> data) async {
    final myDb = await DbHelper.database();
    myDb.rawUpdate('UPDATE user_tasks SET isDone = ? WHERE taskName = ?',
    [data['isDone'], data['taskName']]);
  }

  static Future<void> delete(String table, String task) async {
    final myDb = await DbHelper.database();
    myDb.delete(table, where: 'taskName = ?', whereArgs: [task]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final myDb = await DbHelper.database();
    return myDb.query(table, columns: ['taskName', 'isDone']);
  }

}

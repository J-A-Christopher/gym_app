import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'chest.db'),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE chest(id TEXT PRIMARY KEY, type TEXT, subtype TEXT, reps INT, sets INT, kgs FLOAT, time TEXT)'),
        version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<int> deletePrac(String id) async {
    final db = await DBHelper.database();

    var id1 = await db.delete('chest', where: 'id = ?', whereArgs: [id]);
    return id1;
  }
}

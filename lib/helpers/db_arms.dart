import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper1 {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'arms.db'),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE arms(id TEXT PRIMARY KEY, type TEXT, subtype TEXT, reps INT, sets INT, kgs FLOAT, time TEXT)'),
        version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper1.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper1.database();
    return db.query(table);
  }

  static Future<int> deletePrac(String id) async {
    final db = await DBHelper1.database();

    var id1 = await db.delete('arms', where: 'id = ?', whereArgs: [id]);
    return id1;
  }
}

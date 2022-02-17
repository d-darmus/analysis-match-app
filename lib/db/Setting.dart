import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class Setting{
  final int recId;
  final String custom1;
  final String custom2;

  Setting({
    required this.recId,
    required this.custom1,
    required this.custom2
  }); 
  
  Map<String, dynamic> toMap(){
    return {
      'recId':recId,
      'custom1':custom1,
      'custom2':custom2,
    };
  }

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(),'setting.db'),
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE setting(recId INTEGER PRIMARY KEY, custom1 TEXT, custom2 TEXT )",
        );
      },
      version: 1,
    );
    return _database;
  }

  /** データの取得 */
  static Future<List<Setting>> getDatas() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('setting');
    return List.generate(maps.length,(i){
      return Setting(
        recId: maps[i]['recId'],
        custom1: maps[i]['custom1'],
        custom2: maps[i]['custom2'],
      );
    });
  }

  /** データの挿入 */
  static Future<void> insertData(Setting data) async {
    final Database db = await database;
    await db.insert(
      'setting',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /** データの削除 */
  static Future<void> deleteData(int recId) async {
    final db = await database;
    await db.delete(
      'setting',
      // where: "recId = ?",
      // whereArgs: [recId],
    );
  }
}

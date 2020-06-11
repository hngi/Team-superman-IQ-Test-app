import 'dart:async';
import 'dart:io';

import 'package:example/database/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScoreDatabase {
  ScoreDatabase._();
  static final ScoreDatabase db = ScoreDatabase._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var path = await getDatabasesPath();
    var dbPath = join(path, 'Scores.db');
    // ignore: argument_type_not_assignable
    return await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      print("executing create query from onCreate callback");
      await db.execute('''
        create table Scores(
          id integer primary key autoincrement,
          name text,
          mark mark not null
        );
      ''');
    });
  }

  Future<List<Score>> getAllClients() async {
    final db = await database;
    var res = await db.query("Scores");
    List<Score> list =
        res.isNotEmpty ? res.map((c) => Score.fromMap(c)).toList() : [];
    print(list);

    return list;
  }

  Future<void> deleteNote(int id) async {
    // Get a reference to the database.
    final db = await database;

    await db.delete(
      'Scores',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  newScore(Score newScore) async {
    final db = await database;
    var res = await db.insert("Scores", newScore.toMap());
    return res;
  }
}

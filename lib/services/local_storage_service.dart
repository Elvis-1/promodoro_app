import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper with ChangeNotifier {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'work_history.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE work_entries(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            start_timestamp TEXT,
            stop_timestamp TEXT
          )
          ''',
        );
      },
    );
  }

  Future<int> insertWorkEntry(Map<String, dynamic> entry) async {
    final db = await database;
    return await db.insert('work_entries', entry);
  }

  Future<List<Map<String, dynamic>>> fetchWorkEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> entries = await db.query('work_entries');
    return entries;
  }
}

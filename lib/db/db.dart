import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static const String dbName = 'dadascanner.db';
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  static Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    Directory dbPath = await getApplicationDocumentsDirectory();
    final dbFilePath = join(dbPath.path, dbName);
      print('Path: $dbFilePath');
    return openDatabase(dbFilePath, version: 1, onCreate: (db, version) async {
      print('Creating DB');
      await db.execute('''
          CREATE TABLE Scans (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            value TEXT,
            description TEXT
          );
        ''');
    });
  }
}

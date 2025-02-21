import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
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
    // debugPrint('Path: $dbFilePath');
    return openDatabase(
      dbFilePath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }

  static FutureOr<void> _onCreate(db, version) async {
    // debugPrint('Creating DB');
    await db.execute('''
        CREATE TABLE Scans (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT,
          value TEXT,
          description TEXT
        );
      ''');
  }

  static FutureOr<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) {
    debugPrint('Old version: $oldVersion');
    debugPrint('New version: $newVersion');
  }

  static FutureOr<void> _onDowngrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (newVersion == 1) {
      await db.execute('DROP TABLE IF EXISTS Scans');
      await _onCreate(db, newVersion);
    }
  }
}

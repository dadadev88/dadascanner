import 'package:sqflite/sqflite.dart';

class DatabaseMigrations {
  static void migrateFrom1To2(Database db) async {
    await db.execute('ALTER TABLE Scans ADD COLUMN description TEXT');
  }

  static void migrateFrom2To3(Database db) async {
    await db.execute('ALTER TABLE Scans ADD COLUMN newField TEXT');
  }

  static void onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      migrateFrom1To2(db);
    }
    if (oldVersion < 3) {
      migrateFrom2To3(db);
    }
  }
}
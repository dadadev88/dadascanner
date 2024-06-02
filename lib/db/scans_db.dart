import 'package:dadascanner/models/scan_model.dart';
import 'package:dadascanner/db/db.dart';

class ScansDB {
  static const table = 'Scans';

  static Future<int> create(Scan scan) async {
    final db = await DBProvider.database;
    return await db!.insert(table, scan.toMap());
  }

  static Future<Scan?> getById(String id) async {
    final db = await DBProvider.database;
    final query = await db!.query(table, where: 'id == ?', whereArgs: [id]);
    return query.isNotEmpty ? Scan.fromMap(query.first) : null;
  }

  static Future<List<Scan>> getByType(String type) async {
    final db = await DBProvider.database;
    final query = await db!.query(table, where: 'type == ?', whereArgs: [type]);
    return query.map((e) => Scan.fromMap(e)).toList();
  }

  static Future<List<Scan>> getAll() async {
    final db = await DBProvider.database;
    final query = await db!.query(table);
    return query.map((e) => Scan.fromMap(e)).toList();
  }

  static Future<void> update(String id, String description) async {
    final db = await DBProvider.database;
    final query = await db!.query(table, where: 'id == ?', whereArgs: [id]);
    final Scan scan = Scan.fromMap(query.first);
    scan.description = description;
    await db.update(table, scan.toMap(), where: 'id == ?', whereArgs: [id]);
  }

  static removeAll() async {
    final db = await DBProvider.database;

    db!.rawDelete('''
      DELETE FROM $table WHERE id IS NOT NULL;
    ''');
  }

  static removeAllByType(String type) async {
    final db = await DBProvider.database;

    db!.delete(table, where: 'type = ?', whereArgs: [type]);
  }

  static removeById(int id) async {
    final db = await DBProvider.database;
    db!.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}

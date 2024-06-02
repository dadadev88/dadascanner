import 'package:dadascanner/db/scans_db.dart';
import 'package:dadascanner/models/scan_model.dart';
import 'package:flutter/material.dart';

class ScansProvider extends ChangeNotifier {
  List<Scan> scans = [];
  String currentType = 'LOCATION';

  set changeCurrentType(String type) {
    currentType = type;
  }

  getScansByType(String type) async {
    final scansDB = await ScansDB.getByType(type);
    scans = scansDB;
    notifyListeners();
  }

  create(Scan scan) async {
    final newScan = await ScansDB.create(scan);
    currentType = scan.type!;
    scans = [...scans, Scan(value: scan.value, id: newScan)];
    notifyListeners();
  }

  update(String id, String description) async {
    await ScansDB.update(id, description);
    getScansByType(currentType);
    notifyListeners();
  }

  removeByType() async {
    await ScansDB.removeAllByType(currentType);
    scans = [];
    notifyListeners();
  }

  removeById(int id) async {
    await ScansDB.removeById(id);
    this.scans = this.scans.where((scan) => scan.id != id).toList();
    notifyListeners();
  }
}

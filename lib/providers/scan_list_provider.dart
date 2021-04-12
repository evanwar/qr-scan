import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectType = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(valor: value);
    final id = await DBProvider.db.newScanRecord(newScan);
    newScan.id = id;
    if (this.selectType == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  getScans() async {
    final data = await DBProvider.db.getScans();

    this.scans = data;

    notifyListeners();
  }

  loadScanByType(String type) async {
    final data = await DBProvider.db.getScansByType(type);

    this.scans = data;
    this.selectType = type;

    notifyListeners();
  }

  deleteById(int id) async {
    final result = await DBProvider.db.deleteScansById(id);

    this.scans.removeWhere((element) => element.id == id);

    notifyListeners();

    return result;
  }

  deleteAll() async {
    final result = await DBProvider.db.deleteScans();

    this.scans = [];

    notifyListeners();

    return result;
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDb();
    }

    return _database;
  }

  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );

      ''');
    });
  }

  Future<int> newScanRecord(ScanModel scan) async {
    final db = await database;

    final res = await db.insert('Scans', scan.toJson());

    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id= ?', whereArgs: [id]);

    return res.isEmpty ? null : ScanModel.fromJson(res.first);
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;

    final res = await db.query('Scans');

    return res.isEmpty ? [] : res.map((e) => ScanModel.fromJson(e)).toList();
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;

    final res = await db.query('Scans', where: 'tipo=?', whereArgs: [type]);

    return res.isEmpty ? [] : res.map((e) => ScanModel.fromJson(e)).toList();
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db
        .update('Scans', scan.toJson(), where: "id=?", whereArgs: [scan.id]);

    return res;
  }

  Future<int> deleteScansById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: "id=?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}

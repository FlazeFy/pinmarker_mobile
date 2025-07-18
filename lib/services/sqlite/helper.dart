import 'dart:async';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'pinmarker_stage.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tracker (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        battery_indicator INTEGER,
        track_lat DOUBLE,
        track_long DOUBLE,
        track_type TEXT,
        created_at TEXT,
        is_sync BOOLEAN
      )
    ''');
    await db.execute('''
      CREATE TABLE pin_local (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pin_name TEXT,
        pin_coor TEXT,
        pin_category TEXT,
        stored_at TEXT,
        distance REAL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllPinLocal() async {
    final db = await DatabaseHelper().database;
    return await db.query(
      'pin_local',
      orderBy: 'pin_name DESC',
      limit: 10,
    );
  }

  Future<int> insertPinLocal(
      {required String pinName,
      required String pinCoor,
      required String pinCategory,
      required String storedAt,
      required double distance}) async {
    final db = await database;

    Map<String, dynamic> data = {
      'pin_name': pinName,
      'pin_coor': pinCoor,
      'pin_category': pinCategory,
      'stored_at': storedAt,
      'distance': distance
    };

    return await db.insert('pin_local', data);
  }

  Future<int> resetPinLocal() async {
    final db = await database;

    return await db.delete('pin_local');
  }

  Future<int> insertTracker({
    required int batteryIndicator,
    required double trackLat,
    required double trackLong,
    required String trackType,
    required String createdAt,
    required bool isSync,
  }) async {
    final db = await database;

    Map<String, dynamic> data = {
      'battery_indicator': batteryIndicator,
      'track_lat': trackLat,
      'track_long': trackLong,
      'track_type': trackType,
      'created_at': createdAt,
      'is_sync': isSync ? 1 : 0
    };

    return await db.insert('tracker', data);
  }

  Future<List<Map<String, dynamic>>> getAllLastTracker() async {
    final db = await DatabaseHelper().database;
    return await db.query(
      'tracker',
      orderBy: 'created_at DESC',
      limit: 10,
    );
  }

  Future<List<Map<String, dynamic>>> getReadySaveTracker() async {
    final db = await DatabaseHelper().database;
    return await db.query(
      'tracker',
      orderBy: 'created_at DESC',
      where: 'is_sync = ?',
      whereArgs: [0],
    );
  }

  Future<void> updateTrackerSyncStatus(int id, bool isSync) async {
    final db = await database;
    await db.update(
      'tracker',
      {'is_sync': isSync ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

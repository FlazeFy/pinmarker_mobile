import 'dart:async';
import 'package:sqflite/sqflite.dart';
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
        created_by TEXT,
        is_sync BOOLEAN
      )
    ''');
  }

  Future<int> insertTracker({
    required int batteryIndicator,
    required double trackLat,
    required double trackLong,
    required String trackType,
    required String createdAt,
    required String createdBy,
    required bool isSync,
  }) async {
    final db = await database;

    Map<String, dynamic> data = {
      'battery_indicator': batteryIndicator,
      'track_lat': trackLat,
      'track_long': trackLong,
      'track_type': trackType,
      'created_at': createdAt,
      'created_by': createdBy,
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
}
import 'dart:async';

import 'package:play_flutter/01_basics_verify/storage/db_storage/dao/merit_record_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbStorage {
  DbStorage._();

  static DbStorage? _storage;

  static DbStorage get instance {
    _storage ??= DbStorage._();
    return _storage!;
  }

  late Database _db;
  late MeritRecordDao _meritRecordDao;
  MeritRecordDao get meritRecordDao => _meritRecordDao;

  ///打开数据库
  void open() async {
    String databasePath = await getDatabasesPath();
    String dbPath = path.join(databasePath, 'first_station.db');
    _db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    _meritRecordDao = MeritRecordDao(_db);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await MeritRecordDao.createTable(db);
  }
}

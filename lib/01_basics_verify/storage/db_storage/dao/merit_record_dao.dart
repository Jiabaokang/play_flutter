import 'package:play_flutter/01_basics_verify/muyu_demo/models/merit_record.dart';
import 'package:sqflite/sqflite.dart';

class MeritRecordDao {
  final Database database;
  MeritRecordDao(this.database);

  static String tableName = "merit_record";

  static String tableSql = """
    CREATE TABLE $tableName (
      id VARCHAR(64) PRIMARY KEY,
      value INTEGER,
      image TEXT,
      audio TEXT,
      timestamp INTEGER
    )
  """;

  /// 创建表
  static Future<void> createTable(Database db) async {
    await db.execute(tableSql);
  }

  /// 插入数据
  Future<int> insert(MeritRecord record) {
    return database.insert(tableName, record.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// 查询所有数据
  Future<List<MeritRecord>> query() async {
    List<Map<String, Object?>> data = await database.query(tableName);
    return data
        .map((e) => MeritRecord(
              e['id'].toString(),
              e['timestamp'] as int,
              e['value'] as int,
              e['image'].toString(),
              e['audio'].toString(),
            ))
        .toList();
  }
}

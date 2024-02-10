import 'package:attha_nissaya/models/recent.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

abstract class RecentRepository {
  Future<List<Recent>> fetchRecents();
  Future<int> add(Recent recent);
  Future<int> remove(Recent recent);
  Future<Recent> getRecent({required String nsyId});
}

class DatabaseRecentRepository extends RecentRepository {
  DatabaseRecentRepository(this.databaseProvider, this.recentDao);
  final DatabaseHelper databaseProvider;
  final RecentDao recentDao;

  @override
  Future<List<Recent>> fetchRecents() async {
    final db = await databaseProvider.database;
    final results = await db.query(
      recentDao.tableName,
      columns: [
        recentDao.columnNsyId,
        recentDao.columnNsyName,
        recentDao.columnNsyPageNumber,
        recentDao.columnPaliName,
        recentDao.columnPaliPageNumber,
        recentDao.columnDateTime,
      ],
    );
    return recentDao.fromList(results);
  }

  @override
  Future<int> add(Recent recent) async {
    final db = await databaseProvider.database;
    final result = db.insert(
      recentDao.tableName,
      recentDao.toMap(recent),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  @override
  Future<int> remove(Recent recent) async {
    final db = await databaseProvider.database;
    final result = db.delete(
      recentDao.tableName,
      where: '${recentDao.columnNsyId} = ?',
      whereArgs: [recent.nsyId],
    );
    return result;
  }
  
  @override
  Future<Recent> getRecent({required String nsyId}) async{
    final db = await databaseProvider.database;
    final results = await db.query(
      recentDao.tableName,
      columns: [
        recentDao.columnNsyId,
        recentDao.columnNsyName,
        recentDao.columnNsyPageNumber,
        recentDao.columnPaliName,
        recentDao.columnPaliPageNumber,
        recentDao.columnDateTime,
      ],
      where: '${recentDao.columnNsyId} = ?',
      whereArgs: [nsyId],
      limit: 1,
    );
    return recentDao.fromMap(results.first);
  }
}

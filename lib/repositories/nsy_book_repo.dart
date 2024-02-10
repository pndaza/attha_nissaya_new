import 'package:attha_nissaya/models/nsybook.dart';
import 'package:attha_nissaya/repositories/database.dart';

abstract class NsyBookRepository {
  Future<List<NsyBook>> fetchNsyBooks(
      {required String paliBookID, required int paliBookPageNumber});
  Future<int?> getPaliPageNumber(
      {required String nsyBookId, required int nsyPageNumber});
  // Future<int?> getCurrentPageNumber(
  //     {required String nsyBookId, required int nsyPageIndex});
  Future<int> getPrePagesCount({required String nsyBookId});
  Future<int> getFirstPageNumber({required String nsyBookId});
}

class DatabaseNsyBookRepository extends NsyBookRepository {
  DatabaseNsyBookRepository(this.databaseProvider, this.nsyBookDao);
  final DatabaseHelper databaseProvider;
  final NsyBookDao nsyBookDao;

  @override
  Future<List<NsyBook>> fetchNsyBooks(
      {required String paliBookID, required int paliBookPageNumber}) async {
    final sql = '''
    SELECT id, name, nsy_book_page_number FROM pali_nsy_page_map 
    INNER JOIN nsy_books ON pali_nsy_page_map.nsy_book_id = nsy_books.id 
    WHERE pali_book_id = '$paliBookID' 
    AND pali_book_page_number = $paliBookPageNumber 
    AND nsy_book_page_number != 0
    ''';

    final db = await databaseProvider.database;
    final results = await db.rawQuery(sql);
    return nsyBookDao.fromList(results);
  }

  @override
  Future<int?> getPaliPageNumber(
      {required String nsyBookId, required int nsyPageNumber}) async {
    final db = await databaseProvider.database;
    final results = await db.query(
      'pali_nsy_page_map',
      columns: ['pali_book_page_number'],
      where: 'nsy_book_id = ? AND nsy_book_page_number = ?',
      whereArgs: [nsyBookId, nsyPageNumber],
      limit: 1,
    );
    if (results.isEmpty) return null;
    return results.first['pali_book_page_number'] as int;
  }

  @override
  Future<int> getPrePagesCount({required String nsyBookId}) async {
    final db = await databaseProvider.database;
    final results = await db.query(
      'pali_nsy_page_map',
      columns: ['nsy_book_page_number'],
      where: 'nsy_book_id = ?',
      whereArgs: [nsyBookId],
      limit: 1,
    );
    if (results.isEmpty) return 1;
    final first = results.first['nsy_book_page_number'] as int;
    return first - 1;
  }
  
  @override
  Future<int> getFirstPageNumber({required String nsyBookId}) async{
    final db = await databaseProvider.database;
    final results = await db.query(
      'pali_nsy_page_map',
      columns: ['nsy_book_page_number'],
      where: 'nsy_book_id = ?',
      whereArgs: [nsyBookId],
      limit: 1,
    );
    return results.first['nsy_book_page_number'] as int;
  }
  
  // @override
  // Future<int?> getCurrentPageNumber({required String nsyBookId, required int nsyPageIndex}) async{
  //   final db = await databaseProvider.database;
  //   final results = await db.query(
  //     'pali_nsy_page_map',
  //     columns: ['nsy_book_page_number'],
  //     where: 'nsy_book_id = ?',
  //     whereArgs: [nsyBookId],
  //   );
  //   final pages = results.map((e) => e['nsy_book_page_number'] as int).toList();
  //   return pages[nsyPageIndex];
  // }
}

import 'package:attha_nissaya/models/nsybook.dart';
import 'package:attha_nissaya/repositories/database.dart';

abstract class NsyBookRepository {
  Future<List<NsyBook>> fetchNsyBooks(
      {required String paliBookID, required int paliBookPageNumber});
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
}

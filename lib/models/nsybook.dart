import 'package:freezed_annotation/freezed_annotation.dart';

part 'nsybook.freezed.dart';

@freezed
class NsyBook with _$NsyBook {
  factory NsyBook(
      {required String id,
      required String name,
      required int gotoPage}) = _NsyBook;
}

class NsyBookDao {
  final tableNsy = 'nsy_books';
  final columnID = 'id';
  final columnName = 'name';
  final tablePageMap = 'pali_nsy_page_map';
  final columnPaliBookID = 'page_book_id';
  final columnPaliBookPageNumber = 'pali_book_page_number';
  final columnNsyBookID = 'nsy_book_id';
  final columnNsyBookPageNumber = 'nsy_book_page_number';

  NsyBook fromMap(Map<String, dynamic> map) {
    return NsyBook(
      id: map[columnID] as String,
      name: map[columnName] as String,
      gotoPage: map[columnNsyBookPageNumber] as int,
    );
  }

  List<NsyBook> fromList(List<Map<String, dynamic>> query) {
    return query.map((e) => fromMap(e)).toList();
  }
}

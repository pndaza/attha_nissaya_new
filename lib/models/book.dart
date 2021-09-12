import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

@freezed
class Book with _$Book {
  const factory Book(
      {required String id,
      required String name,
      required int categoryID,
      required String categoryDescription,
      required int firstPage,
      required int lastPage,
      required int count}) = _Book;
}

class BookDao {
  final tableName = 'pali_books';
  final columnID = 'id';
  final columnName = 'name';
  final columnCategoryID = 'category_id';
  final columnCategoryDescription = 'category_description';
  final columnFirstPage = 'first_page';
  final columnLastPage = 'last_page';
  final columnCount = 'count';

  Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map[columnID] as String,
      name: map[columnName] as String,
      categoryID: map[columnCategoryID] as int,
      categoryDescription: map[columnCategoryDescription] as String,
      firstPage: map[columnFirstPage] as int,
      lastPage: map[columnLastPage] as int,
      count: map[columnCount] as int,
    );
  }

  List<Book> fromList(List<Map<String, dynamic>> query) {
    return query.map((e) => fromMap(e)).toList();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/book.dart';
import '../../../../repositories/book_repo.dart';
import '../../../../repositories/database.dart';

final paliBookRepoProvider = Provider(
  (_) => DatabaseBookRepository(DatabaseHelper(), BookDao()),
);

final paliBooksProvider = FutureProvider<List<Book>>((ref) async {
  final bookRepository = ref.read(paliBookRepoProvider);
  final books = await bookRepository.fetchBooks();
  return books;
});

class BookListTabPageController {
  final WidgetRef ref;
  BookListTabPageController({
    required this.ref,
  });
}

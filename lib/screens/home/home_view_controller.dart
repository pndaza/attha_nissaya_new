import 'package:attha_nissaya/screens/info/info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book.dart';
import '../../repositories/book_repo.dart';
import '../../repositories/database.dart';
import '../page_number_list/page_choice.dart';

final paliBookRepoProvider =
    Provider((_) => DatabaseBookRepository(DatabaseHelper(), BookDao()));

final paliBooksProvider = FutureProvider<List<Book>>((ref) async {
  final bookRepository = ref.read(paliBookRepoProvider);
  final books = await bookRepository.fetchBooks();
  return books;
});

final homeViewController = Provider((_) => HomeViewController());

class HomeViewController {
  void onBookItemClicked(BuildContext context, Book book) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PageChoice(
              book: book,
            )));
  }

  void onInfoClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const InfoPage()));
  }
}

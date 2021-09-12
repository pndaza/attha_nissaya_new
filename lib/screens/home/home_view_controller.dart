import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attha_nissaya/models/book.dart';
import 'package:attha_nissaya/repositories/book_repo.dart';
import 'package:attha_nissaya/repositories/database.dart';
import 'package:attha_nissaya/screens/page_list/page_choice.dart';

final paliBookRepoProvider =
    Provider((_) => DatabaseBookRepository(DatabaseHelper(), BookDao()));

final paliBooksProvider = FutureProvider<List<Book>>((ref) async {
  final bookRepository = ref.read(paliBookRepoProvider);
  final books = await bookRepository.fetchBooks();
  return books;
});

final homeViewController = Provider((_) => HomeViewController());

class HomeViewController {
  void openPageChoice(BuildContext context, Book book) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PageChoice(
              book: book,
            )));
  }
}

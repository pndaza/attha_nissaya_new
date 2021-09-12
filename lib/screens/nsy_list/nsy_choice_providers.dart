import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/nsybook.dart';
import '../../repositories/database.dart';
import '../../repositories/nsy_book_repo.dart';
import '../reader/book_reader.dart';

final nsyBookRepoProvider =
    Provider((_) => DatabaseNsyBookRepository(DatabaseHelper(), NsyBookDao()));

final nsyBooksProvider =
    FutureProvider.family<List<NsyBook>, String>((ref, idAndPageNumber) async {
  final nsyBookRepo = ref.read(nsyBookRepoProvider);
  final tmp = idAndPageNumber.split('-');
  final paliBookID = tmp[0];
  final paliBookPageNumber = int.parse(tmp[1]);
  final nsyBooks = await nsyBookRepo.fetchNsyBooks(
      paliBookID: paliBookID, paliBookPageNumber: paliBookPageNumber);
  return nsyBooks;
});

final nsyChoiceViewController = Provider((_) => NsyChoiceViewController());

class NsyChoiceViewController {
  void openBook(BuildContext context, NsyBook nsyBook) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BookReader(
            id: nsyBook.id, name: nsyBook.name, pageNumber: nsyBook.gotoPage)));
  }
}

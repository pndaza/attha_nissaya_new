import 'package:attha_nissaya/screens/home/sub_pages/book_list_page/book_list_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/nsybook.dart';
import '../../models/recent.dart';
import '../../repositories/database.dart';
import '../../repositories/nsy_book_repo.dart';
import '../home/sub_pages/recent_page/recent_page_controller.dart';
import '../reader/reader_page.dart';

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
        builder: (_) => ReaderPage(
            id: nsyBook.id, name: nsyBook.name, pageNumber: nsyBook.gotoPage)));
  }

  void onNsyBookClicked(WidgetRef ref, NsyBook nsyBook, String paliBookId,
      int paliBookPageNumber) async {
    final recentRepo = ref.read(recentRepoProvider);
    final bookRepo = ref.read(paliBookRepoProvider);

    final paliBookName = await bookRepo.getBookName(id: paliBookId);

    final recent = Recent(
      nsyId: nsyBook.id,
      nsyName: nsyBook.name,
      nsyPageNumber: nsyBook.gotoPage,
      paliName: paliBookName,
      paliPageNumber: paliBookPageNumber,
      dateTime: DateTime.now(),
    );
    // debugPrint(recent.toString());
    recentRepo.add(recent);
  }
}

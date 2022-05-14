import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book.dart';
import '../nsy_list/nsy_choice.dart';

final pageChoiceViewController = Provider((_) => PageChoiceViewController());

class PageChoiceViewController {
  void onPageNumberClicked(BuildContext context, Book book, int pageNumber) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            NsyChoice(paliBookID: book.id, paliBookPageNumber: pageNumber)));
  }
}

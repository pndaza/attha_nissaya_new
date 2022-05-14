import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../models/book.dart';
import 'page_choice_providers.dart';
import 'page_number_listview.dart';
import 'section_listview.dart';

class PageChoice extends ConsumerWidget {
  PageChoice({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('စာမျက်နှာရွေးပါ'),
      ),
      body: Row(
        children: [
          Expanded(
            child: PageNumberListView(
              firstPage: book.firstPage,
              lastPage: book.lastPage,
              onPageNumberClicked: (pageNumber) => ref
                  .read(pageChoiceViewController)
                  .onPageNumberClicked(context, book, pageNumber),
              itemScrollController: itemScrollController,
            ),
          ),
          SectionListView(
            firstPage: book.firstPage,
            lastPage: book.lastPage,
            itemScrollController: itemScrollController,
          )
        ],
      ),
    );
  }
}

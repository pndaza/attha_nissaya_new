import 'package:attha_nissaya/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../models/book.dart';
import '../nsy_list/nsy_choice.dart';
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
              onPageNumberClicked: (pageNumber) {
                context.goto(NsyChoice(
                    paliBookID: book.id,
                    paliBookName: book.name,
                    paliBookPageNumber: pageNumber));
              },
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

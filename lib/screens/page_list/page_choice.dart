import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../models/book.dart';
import 'page_listview.dart';
import 'section_listview.dart';

class PageChoice extends StatelessWidget {
  PageChoice({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('စာမျက်နှာရွေးပါ'),
      ),
      body: Row(
        children: [
          Expanded(
            child: PageListView(
              book: book,
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

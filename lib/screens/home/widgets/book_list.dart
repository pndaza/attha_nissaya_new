import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../models/book.dart';
import '../home_view_controller.dart';
import 'book_list_tile.dart';
import 'header_view.dart';

class PaliBookList extends ConsumerWidget {
  const PaliBookList({Key? key, required this.books}) : super(key: key);
  final List<Book> books;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GroupedListView<Book, String>(
      elements: books,
      groupBy: (element) =>
          '${element.categoryID}--${element.categoryDescription}',
      itemComparator: (element1, element2) =>
          element1.id.compareTo(element2.id),
      groupSeparatorBuilder: (String groupByValue) =>
          HeaderView(categoryName: groupByValue),
      itemBuilder: (context, element) => BookListTile(
        book: element,
        onTap: () {
          ref.read(homeViewController).onBookItemClicked(context, element);
        },
      ),
    );
  }
}

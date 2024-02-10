import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../models/book.dart';
import '../../../../../utils/navigation_helper.dart';
import '../../../../page_number_list/page_choice.dart';
import 'book_list_tile.dart';
import 'header_view.dart';

class PaliBookList extends ConsumerWidget {
  const PaliBookList({Key? key, required this.books}) : super(key: key);
  final List<Book> books;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GroupedListView<Book, String>(
      elements: books,
      groupBy: (book) => '${book.categoryID}--${book.categoryDescription}',
      itemComparator: (element1, element2) =>
          element1.id.compareTo(element2.id),
      groupSeparatorBuilder: (String groupByValue) =>
          HeaderView(categoryName: groupByValue),
      itemBuilder: (context, book) => BookListTile(
        book: book,
        onTap: () => context.goto(PageChoice(book: book)),
      ),
    );
  }
}

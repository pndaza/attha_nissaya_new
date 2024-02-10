import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/error_view.dart';
import '../../../../widgets/loading_view.dart';
import 'book_list_page_controller.dart';
import 'widgets/book_list.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paliBooksProvider);

    return state.when(
      data: (books) => PaliBookList(books: books),
      loading: () => const LoadingView(),
      error: (object, stackTrace) => const ErrorView(),
    );
  }
}

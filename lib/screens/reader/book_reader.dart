import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/pdf_viewer/pdf_controller.dart';
import '../../widgets/pdf_viewer/pdf_viewer.dart';
import 'reader_appbar.dart';
import 'reader_view_controller.dart';

class BookReader extends ConsumerWidget {
  final String id;
  final String? name;
  final int pageNumber;

  const BookReader({Key? key, required this.id, this.name, this.pageNumber = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfController = PdfController(intialPage: pageNumber);

    return Scaffold(
      appBar: ReaderAppBar(
        bookID: id,
        bookName: name,
      ),
      body: GestureDetector(
        onTap: () {
          ref.read(readerViewController).toggleFullScreenMode();
        },
        child: Consumer(
          builder: (context, watch, child) {
            final _scrollDirection = ref.watch(scrollDirectionProvider);
            return MyPdfViewer(
              assetPath: 'assets/books/pdf/$id.pdf',
              scrollDirection: _scrollDirection,
              pdfController: pdfController,
            );
          },
        ),
      ),
    );
  }
}

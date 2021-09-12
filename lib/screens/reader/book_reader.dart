import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/pdf_viewer/pdf_viewer.dart';
import './reader_view_controller.dart';
import './reader_appbar.dart';
import '../../widgets/pdf_viewer/pdf_controller.dart';

class BookReader extends StatelessWidget {
  final String id;
  final String? name;
  final int pageNumber;

  const BookReader({Key? key, required this.id, this.name, this.pageNumber = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfController(intialPage: this.pageNumber);

    return Scaffold(
      appBar: ReaderAppBar(
        bookID: id,
        bookName: name,
      ),
      body: GestureDetector(
        onTap: () {
          context.read(readerViewController).toggleFullScreenMode();
        },
        child: Consumer(
          builder: (context, watch, child) {
            final _scrollDirection = watch(scrollDirectionProvider).state;
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

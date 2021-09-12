import 'package:flutter/material.dart';
import 'pdf_controller.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import 'pdf_info.dart';

typedef OnPageChanged = void Function(int);

class MyPdfViewer extends StatefulWidget {
  final String assetPath;
  final Axis scrollDirection;
  final PdfController? pdfController;
  final OnPageChanged? onPageChanged;

  const MyPdfViewer(
      {Key? key,
      required this.assetPath,
      this.scrollDirection = Axis.vertical,
      this.pdfController,
      this.onPageChanged})
      : super(key: key);

  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  ScrollController? _scrollController;

  @override
  Widget build(BuildContext context) {
    final pdfInfo = _loadPdf(widget.assetPath);
    final initialPage = widget.pdfController?.intialPage ?? 1;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final parentWidth = constraints.maxWidth;
        final parentHeight = constraints.maxHeight;

        return FutureBuilder(
          future: pdfInfo,
          builder: (BuildContext context, AsyncSnapshot<PdfInfo> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Something worng'),
              );
            }
            final pdfInfo = snapshot.data!;
            double viewportFraction = findViewportFraction(
                scrollAxis: widget.scrollDirection,
                parentWidth: parentWidth,
                parentHeight: parentHeight,
                pdfWidth: pdfInfo.width,
                pdfHeight: pdfInfo.height);

            _scrollController = PageController(
                initialPage: initialPage - 1,
                viewportFraction: viewportFraction);

            widget.pdfController
                ?.attachController(_scrollController as PageController);

            return _buildPdfView(context, pdfInfo, initialPage);
          },
        );
      },
    );
  }

  Widget _buildPdfView(
    BuildContext context,
    PdfInfo pdfInfo,
    int initialPage,
  ) {
    return VsScrollbar(
      style: VsScrollbarStyle(thickness: 24, color: Colors.blueGrey),
      controller: _scrollController,
      child: InteractiveViewer(
        child: PageView.builder(
            controller: _scrollController as PageController,
            scrollDirection: widget.scrollDirection,
            pageSnapping:
                widget.scrollDirection == Axis.horizontal ? true : false,
            onPageChanged: widget.onPageChanged == null
                ? null
                : (index) => widget.onPageChanged?.call(index + 1),
            itemCount: pdfInfo.pageCount,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(1),
                color: Colors.grey[300],
                child: PdfPageView(
                    pdfDocument: pdfInfo.document, pageNumber: index + 1),
              );
            }),
      ),
    );
  }

  Future<PdfInfo> _loadPdf(String assetPath) async {
    final doc = await PdfDocument.openAsset(assetPath);
    final pageCount = doc.pageCount;
    final page = pageCount > 55 ? await doc.getPage(55) : await doc.getPage(1);
    final pageImage = await page.render();
    final width = pageImage.width;
    final height = pageImage.height;

    return PdfInfo(doc, pageCount, width, height);
  }

  double findViewportFraction(
      {required Axis scrollAxis,
      required double parentWidth,
      required double parentHeight,
      required int pdfWidth,
      required int pdfHeight}) {
    if (scrollAxis == Axis.horizontal) {
      return 1.0;
    }

    final screnAspectRatio = parentHeight / parentWidth;
    final pdfAspectRatio = pdfHeight / pdfWidth;
    return pdfAspectRatio / screnAspectRatio;
  }
}

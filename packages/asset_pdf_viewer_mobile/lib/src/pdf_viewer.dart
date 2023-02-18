import 'package:flutter/material.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'pdf_controller.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:pdf_render/pdf_render.dart';
import 'pdf_page_view.dart';

import 'pdf_info.dart';

typedef OnPageChanged = void Function(int);

class AssetPdfViewer extends StatefulWidget {
  final String assetPath;
  final Axis scrollDirection;
  final PdfController? pdfController;
  final OnPageChanged? onPageChanged;
  final ColorMode colorMode;

  const AssetPdfViewer({
    Key? key,
    required this.assetPath,
    this.scrollDirection = Axis.vertical,
    this.pdfController,
    this.onPageChanged,
    this.colorMode = ColorMode.day,
  }) : super(key: key);

  @override
  _AssetPdfViewer createState() => _AssetPdfViewer();
}

class _AssetPdfViewer extends State<AssetPdfViewer> {
  ScrollController? _scrollController;
  late final Future<PdfInfo> pdfInfo;
  late final int initialPage;
  late double viewportRatio;
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    pdfInfo = _loadPdf(widget.assetPath);
    initialPage = widget.pdfController?.intialPage ?? 1;
    currentPageIndex = initialPage - 1;
  }

  @override
  Widget build(BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _gotoTopOfpage());

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final parentWidth = constraints.maxWidth;
        final parentHeight = constraints.maxHeight;

        viewportRatio = parentHeight / parentWidth;
        
        return FutureBuilder(
          future: pdfInfo,
          builder: (BuildContext context, AsyncSnapshot<PdfInfo> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something worng'));
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
      style: const VsScrollbarStyle(thickness: 24, color: Colors.blueGrey),
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
                padding: const EdgeInsets.all(2),
                color: _getBackGroundColor(widget.colorMode),
                child: MyPdfPageView(
                  pdfPageView: PdfPageView(
                      pdfDocument: pdfInfo.document, pageNumber: index + 1),
                  colorMode: widget.colorMode,
                ),
              );
            }),
      ),
    );
  }

  Future<PdfInfo> _loadPdf(String assetPath) async {
    final doc = await PdfDocument.openAsset(assetPath);
    final pageCount = doc.pageCount;
    final page = pageCount > 10 ? await doc.getPage(55) : await doc.getPage(1);
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

  Color _getBackGroundColor(ColorMode colorMode) {
    switch (colorMode) {
      case ColorMode.day:
        return Colors.white;
      case ColorMode.night:
        return Colors.black;
      case ColorMode.speia:
        return const Color.fromARGB(255, 255, 255, 213);
      case ColorMode.grayscale:
        return Colors.grey;
    }
  }
  void _gotoTopOfpage() async {
    // debugPrint('need scroll: $isNeedScrollToTop');
    if (viewportRatio > 1.55) return;
    // _scroll controller is still not initialized
    // need to wait
    await Future.delayed(const Duration(milliseconds: 150));

    double? offset = _scrollController?.offset;
    if (offset == null) return;

    late double value;
    if (viewportRatio > 1.4) {
      value = 50;
    } else if (viewportRatio > 1.3) {
      value = 80;
    } else if (viewportRatio > 1.2) {
      value = 110;
    } else if (viewportRatio > 1.1) {
      value = 150;
    } else if (viewportRatio > 1) {
      value = 200;
    } else if (viewportRatio > 0.9) {
      value = 260;
    } else if (viewportRatio > 0.8) {
      value = 320;
    } else if (viewportRatio > 0.7) {
      value = 400;
    } else if (viewportRatio > 0.6) {
      value = 500;
    } else {
      value = 600;
    }
    // estimate
    offset = offset - value;
    if (offset < 0) {
      // first page case
      _scrollController?.jumpTo(0);
    } else {
      _scrollController?.jumpTo(offset);
    }
  }
}

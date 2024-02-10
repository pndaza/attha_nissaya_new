import 'package:asset_pdf_viewer/asset_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'reader_view_controller.dart';

class ReaderAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String bookID;
  final String? bookName;

  const ReaderAppBar({Key? key, required this.bookID, this.bookName})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollDirection = ref.watch(scrollDirectionProvider);
    final pdfColorMode = ref.watch(pdfColorModeProvider);
    final isFullScreenMode = ref.watch(fullScreenStateProvider);

    // if (isFullScreenMode) {
    //   final statusBarHeight = MediaQuery.of(context).padding.top;
    //   return Container(
    //     height: statusBarHeight,
    //   );
    // }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isFullScreenMode ? 0 : AppBar().preferredSize.height,
      child: AppBar(
        title: Text(bookName ?? ''),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(scrollDirection == Axis.horizontal
                  ? Icons.swap_horiz
                  : Icons.swap_vert),
              onPressed: () async {
                ref
                    .read(readerViewController)
                    .toggleScrollDirection(scrollDirection);
              }),
          PopupMenuButton<ColorMode>(
            icon: const Icon(Icons.palette_outlined),
            initialValue: pdfColorMode,
            itemBuilder: (_) => [
              CheckedPopupMenuItem(
                padding: EdgeInsets.zero,
                checked: ColorMode.day == pdfColorMode,
                value: ColorMode.day,
                child: const Text('အဖြူ'),
              ),
              CheckedPopupMenuItem(
                padding: EdgeInsets.zero,
                checked: ColorMode.night == pdfColorMode,
                value: ColorMode.night,
                child: const Text('အမဲ'),
              ),
              CheckedPopupMenuItem(
                padding: EdgeInsets.zero,
                checked: ColorMode.speia == pdfColorMode,
                // padding: EdgeInsets.only(left: 16),
                value: ColorMode.speia,
                child: const Text('ဝါကျင့်ကျင့်'),
              ),
            ],
            onSelected: (colorMode) {
              ref.read(readerViewController).changePdfColorMode(colorMode);
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(AppBar().preferredSize.height);
  }
}

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

    if (isFullScreenMode) {
      final statusBarHeight = MediaQuery.of(context).padding.top;
      return Container(
        height: statusBarHeight,
      );
    }

    return AppBar(
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
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: ColorMode.day,
              child: Text('အဖြူ'),
            ),
            PopupMenuItem(
              value: ColorMode.night,
              child: Text('အမဲ'),
            ),
            PopupMenuItem(
              padding: EdgeInsets.only(left: 16),
              value: ColorMode.speia,
              child: Text('ဝါကျင့်ကျင့်'),
            ),
          ],
          onSelected: (colorMode) {
            ref.read(readerViewController).changePdfColorMode(colorMode);
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(AppBar().preferredSize.height);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './reader_view_controller.dart';

class ReaderAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String bookID;
  final String? bookName;

  const ReaderAppBar({
    required this.bookID,
    this.bookName,
  });

  @override
  Widget build(BuildContext context, watch) {
    final scrollDirection = watch(scrollDirectionProvider).state;
    final isFullScreenMode = watch(fullScreenStateProvider).state;

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
            icon: Icon(scrollDirection == Axis.vertical
                ? Icons.swap_horiz
                : Icons.swap_vert),
            onPressed: () async {
              context
                  .read(readerViewController)
                  .toggleScrollDirection(scrollDirection);
            })
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(AppBar().preferredSize.height);
  }
}

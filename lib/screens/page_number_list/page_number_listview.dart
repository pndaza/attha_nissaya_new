import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class PageNumberListView extends StatelessWidget {
  const PageNumberListView(
      {Key? key,
      required this.firstPage,
      required this.lastPage,
      required this.onPageNumberClicked,
      this.itemScrollController})
      : super(key: key);

  final int firstPage;
  final int lastPage;
  final void Function(int) onPageNumberClicked;
  final ItemScrollController? itemScrollController;

  @override
  Widget build(BuildContext context) {
    final count = (lastPage - firstPage) + 1;
    return ScrollablePositionedList.separated(
      itemCount: count,
      itemBuilder: (context, index) {
        final pageNumber = index + firstPage;
        return Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: ListTile(
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            title: Text('$pageNumber', style: const TextStyle(fontSize: 16.0)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => onPageNumberClicked(pageNumber),
          ),
        );
      },
      itemScrollController: itemScrollController,
      separatorBuilder: (_, __) => const Divider(height: 1.0),
    );
  }
}

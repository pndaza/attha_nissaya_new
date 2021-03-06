import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SectionListView extends StatelessWidget {
  final int firstPage;
  final int lastPage;
  final ItemScrollController? itemScrollController;

  const SectionListView(
      {Key? key,
      required this.firstPage,
      required this.lastPage,
      this.itemScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final step = _getSectionDifference(lastPage - firstPage);
    final sectionList = [];
    sectionList.add(firstPage);
    for (int i = step; i < lastPage; i = i + step) {
      if (i > firstPage) {
        sectionList.add(i);
      }
    }
    sectionList.add(lastPage);

    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 75,
        height: 400,
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            // color: Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(35))),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: sectionList.length,
          itemBuilder: (_, index) {
            return SizedBox(
              height: 36.0,
              width: double.infinity,
              child: ListTile(
                minVerticalPadding: 0.0,
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                title: Text(
                  '${sectionList[index]}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12.0),
                ),
                onTap: () => itemScrollController?.scrollTo(
                    index: sectionList[index] - firstPage,
                    duration: const Duration(milliseconds: 300)),
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(
            height: 1,
          ),
        ),
      ),
    );
  }

  int _getSectionDifference(int pageCount) {
    if (pageCount < 100) return 10;
    if (pageCount < 200) return 20;
    if (pageCount < 300) return 30;
    return 40;
  }
}

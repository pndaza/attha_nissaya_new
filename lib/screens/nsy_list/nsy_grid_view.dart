import 'package:flutter/material.dart';

import '../../models/nsybook.dart';
import 'nsy_grid_item.dart';


class NsyGirdView extends StatelessWidget {
  const NsyGirdView({
    Key? key,
    required this.nsyBooks,
    required this.onItemClicked,
  }) : super(key: key);

  final List<NsyBook> nsyBooks;
  final Function(NsyBook) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 32,
        crossAxisSpacing: 32,
        childAspectRatio: 0.5,
        children: nsyBooks
            .map((nsyBook) => NsyGirdItem(
                  nsyBook: nsyBook,
                  onClicked: ()=> onItemClicked(nsyBook),
                ))
            .toList());
  }
}

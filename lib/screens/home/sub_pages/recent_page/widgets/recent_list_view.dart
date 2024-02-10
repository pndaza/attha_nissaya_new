import 'package:flutter/material.dart';

import '../../../../../models/recent.dart';
import 'recent_list_tile.dart';

class RecentListView extends StatelessWidget {
  const RecentListView({
    Key? key,
    required this.recents,
    this.onItemClicked,
    this.onItemDeleted,
  }) : super(key: key);

  final List<Recent> recents;
  final ValueChanged<Recent>? onItemClicked;
  final ValueChanged<Recent>? onItemDeleted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recents.length,
      itemBuilder: (context, index) {
        final recent = recents[index];
        return RecentListTile(
          onClicked: () => onItemClicked?.call(recent),
          onDeleted: () => onItemDeleted?.call(recent),
          recent: recents[index],
        );
      },
    );
  }
}

class EmpytView extends StatelessWidget {
  const EmpytView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ကြည့်ဆဲနိဿယများ\nမရှိသေးပါ။',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

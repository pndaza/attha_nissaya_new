import 'package:attha_nissaya/utils/mm_number.dart';
import 'package:flutter/material.dart';

import '../../../../../models/recent.dart';

class RecentListTile extends StatelessWidget {
  const RecentListTile({
    Key? key,
    required this.recent,
    this.onClicked,
    this.onDeleted,
  }) : super(key: key);

  final Recent recent;
  final VoidCallback? onClicked;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          onTap: onClicked,
          child: Row(
            children: [
              // leading
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/books/cover/${recent.nsyId}.png'),
                  fit: BoxFit.fitHeight,
                  width: 100,
                ),
              ),

              // body
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${recent.paliName}  နှာ - ${MmNumber.get(recent.paliPageNumber)}'),
                    Text(recent.nsyName)
                  ],
                ),
              ),

              // trailing
              IconButton(icon: const Icon(Icons.delete), onPressed: onDeleted),
              const SizedBox(width: 16)
            ],
          ),
        ),
      ),
    );
  }
}

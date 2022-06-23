import 'package:flutter/material.dart';

import '../../models/nsybook.dart';

class NsyGirdItem extends StatelessWidget {
  const NsyGirdItem({Key? key, required this.nsyBook, this.onClicked})
      : super(key: key);
  final NsyBook nsyBook;
  final VoidCallback? onClicked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Card(
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage('assets/books/cover/${nsyBook.id}.png'),
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 5),
              Expanded(
                  child: Text(nsyBook.name,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
            ],
          ),
        ),
      ),
    );
  }
}

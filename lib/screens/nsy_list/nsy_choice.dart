import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';
import '../home/home_page.dart';
import 'nsy_choice_providers.dart';
import 'nsy_grid_view.dart';

class NsyChoice extends ConsumerWidget {
  const NsyChoice({
    Key? key,
    required this.paliBookID,
    required this.paliBookPageNumber,
    this.isOpenFromDeepLink = false,
  }) : super(key: key);
  final String paliBookID;
  final int paliBookPageNumber;
  final bool isOpenFromDeepLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nsyBookState =
        ref.watch(nsyBooksProvider('$paliBookID-$paliBookPageNumber'));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (isOpenFromDeepLink) {
              Navigator.pop(context);
              // back to homepage
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const Home()));
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('နိဿယ မူကွဲများ'),
      ),
      body: nsyBookState.when(
          data: (nsyBooks) => NsyGirdView(
              nsyBooks: nsyBooks,
              onItemClicked: (nsyBook) =>
                  ref.read(nsyChoiceViewController).openBook(context, nsyBook)),
          loading: () => const LoadingView(),
          error: (_, __) => const ErrorView()),
    );
  }
}

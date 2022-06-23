import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';
import 'home_view_controller.dart';
import 'widgets/book_list.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paliBooksProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('အဋ္ဌကထာနိဿယ'),
          centerTitle: true,
          actions: [
            PopupMenuButton<ThemeMode>(
              icon: const Icon(Icons.palette_outlined),
              initialValue: themeMode,
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: ThemeMode.light,
                  child: Text('နေ့'),
                ),
                PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Text('ည'),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.only(left: 16),
                  value: ThemeMode.system,
                  child: Text('စက်'),
                ),
              ],
              onSelected: (themeMode) {
                ref.read(homeViewController).changeThemeMode(themeMode);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
            ),
            IconButton(
                onPressed: () =>
                    ref.read(homeViewController).onInfoClicked(context),
                icon: const Icon(Icons.info_outlined))
          ],
        ),
        body: state.when(
          data: (books) => PaliBookList(books: books),
          loading: () => const LoadingView(),
          error: (object, stackTrace) => const ErrorView(),
        ));
  }
}

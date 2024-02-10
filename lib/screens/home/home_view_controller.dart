import 'package:attha_nissaya/client/shared_pref_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book.dart';
import '../page_number_list/page_choice.dart';

final themeProvider = StateProvider<ThemeMode>(
  (ref) {
    int themeIndex = SharedPreferenceClient.themeModeIndex;
    return ThemeMode.values[themeIndex];
  },
);



final homeViewController = Provider((ref) => HomeViewController(ref));

class HomeViewController {
  final Ref ref;
  HomeViewController(this.ref);

  void onBookItemClicked(BuildContext context, Book book) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PageChoice(
              book: book,
            )));
  }

  // void onInfoClicked(BuildContext context) {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (_) => const InfoPage()));
  // }

  void changeThemeMode(ThemeMode themeMode) {
    _updateThemeState(themeMode);
    _saveThemeMode(themeMode);
  }

  void _updateThemeState(ThemeMode themeMode) {
    ref.read(themeProvider.notifier).state = themeMode;
  }

  void _saveThemeMode(ThemeMode themeMode) {
    SharedPreferenceClient.themeModeIndex = themeMode.index;
  }
}

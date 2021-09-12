import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

final sharedPreferenceClient =
    Provider((ref) => SharedPreferenceClient(ref.read));

class SharedPreferenceClient {
  SharedPreferenceClient(this.read);
  final Reader read;

  final _scrollDirectionKey = 'scroll_direction';

  Future<int> getRecentPage(int id) async {
    return read(sharedPreferencesProvider).getInt('$id') ?? 1;
  }

  Future<void> saveRecentPage(int bookID, int pageNumber) async {
    await read(sharedPreferencesProvider).setInt('$bookID', pageNumber);
  }

  Axis getScrollDirection() {
    final scrollDirectionValue =
        read(sharedPreferencesProvider).getString(_scrollDirectionKey) ??
            EnumToString.convertToString(Axis.vertical);
    final Axis? scrollDirction =
        EnumToString.fromString(Axis.values, scrollDirectionValue);
    return scrollDirction!;
  }

  Future<void> saveScrollDirection(Axis scrollDirection) async {
    final scrollDirectionValue = EnumToString.convertToString(scrollDirection);
    await read(sharedPreferencesProvider)
        .setString(_scrollDirectionKey, scrollDirectionValue);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../client/shared_pref_client.dart';

final fullScreenStateProvider = StateProvider((_) => false);
final appBarHeight = StateProvider<double>((ref) {
  final isFullScreen = ref.watch(fullScreenStateProvider).state;
  return isFullScreen ? 0 : 56.0;
});
final scrollDirectionProvider = StateProvider<Axis>((ref) {
  return ref.read(sharedPreferenceClient).getScrollDirection();
});


final readerViewController = Provider<ReaderViewController>(
    (ref) => ReaderViewController(read: ref.read));

class ReaderViewController {
  final Reader read;
  ReaderViewController({required this.read});

  Future<void> toggleScrollDirection(Axis scrollDirection) async {
    if (scrollDirection == Axis.vertical) {
      read(scrollDirectionProvider).state = Axis.horizontal;
      read(sharedPreferenceClient).saveScrollDirection(Axis.horizontal);
    } else {
      read(scrollDirectionProvider).state = Axis.vertical;
      read(sharedPreferenceClient).saveScrollDirection(Axis.vertical);
    }
  }

  void toggleFullScreenMode() {
    final screenMode = read(fullScreenStateProvider).state;
    read(fullScreenStateProvider).state = !screenMode;
  }

}

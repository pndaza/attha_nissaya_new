import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../client/shared_pref_client.dart';

final fullScreenStateProvider = StateProvider((_) => false);
final appBarHeight = StateProvider<double>((ref) {
  final isFullScreen = ref.watch(fullScreenStateProvider);
  return isFullScreen ? 0 : 56.0;
});

final scrollDirectionProvider = StateProvider<Axis>((_) {
  return SharedPreferenceClient.scrollDirection;
});

final readerViewController =
    Provider<ReaderViewController>((ref) => ReaderViewController(ref));

class ReaderViewController {
  final Ref ref;
  ReaderViewController(this.ref);

  void toggleScrollDirection(Axis scrollDirection) {
    final value =
        scrollDirection == Axis.horizontal ? Axis.vertical : Axis.horizontal;
    _updateScrollDirectionState(value);
    _saveScrollDirection(value);
  }

  void _updateScrollDirectionState(Axis value) {
    ref.read(scrollDirectionProvider.notifier).state = value;
  }

  void _saveScrollDirection(Axis value) {
    SharedPreferenceClient.scrollDirection = value;
  }

  void toggleFullScreenMode() {
    final screenMode = ref.read(fullScreenStateProvider);
    ref.read(fullScreenStateProvider.notifier).state = !screenMode;
  }
}

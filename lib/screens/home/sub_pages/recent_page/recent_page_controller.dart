import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/recent.dart';
import '../../../../repositories/database.dart';
import '../../../../repositories/recent_repo.dart';

final recentRepoProvider = Provider(
  (_) => DatabaseRecentRepository(DatabaseHelper(), RecentDao()),
);

final recentsProvider = FutureProvider<List<Recent>>((ref) async {
  final recentRepository = ref.read(recentRepoProvider);
  final recents = await recentRepository.fetchRecents();
  return recents;
});

enum RecentState { loading, error, data, empty }

class RecentPageController {
  final RecentRepository recentRepository;
  RecentPageController({
    required this.recentRepository,
  });

  // final ValueNotifier<List<Recent>> _recents = ValueNotifier<List<Recent>>([]);
  // ValueListenable<List<Recent>> get recents => _recents;
  List<Recent> _recents = [];
  List<Recent> get recents => _recents;

  final ValueNotifier<RecentState> _state =
      ValueNotifier<RecentState>(RecentState.loading);
  ValueListenable<RecentState> get state => _state;

  void init() {
    _load();
  }

  Future<void> _load() async {
    _state.value = RecentState.loading;
    _recents = await recentRepository.fetchRecents();
    if (recents.isEmpty) {
      _state.value = RecentState.empty;
    } else {
      _state.value = RecentState.data;
    }
  }

  void onDeleted(Recent recent) async {
    // delete from record
    await recentRepository.remove(recent);
    _load();
  }
}

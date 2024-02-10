import 'package:asset_pdf_viewer/asset_pdf_viewer.dart';
import 'package:attha_nissaya/screens/home/sub_pages/recent_page/recent_page_controller.dart';
import 'package:attha_nissaya/screens/nsy_list/nsy_choice_providers.dart';
import 'package:easy_debounce/easy_debounce.dart';
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

final pdfColorModeProvider = StateProvider<ColorMode>((_) {
  int colorIndex = SharedPreferenceClient.pdfThemeModeIndex;
  return ColorMode.values[colorIndex];
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

  void changePdfColorMode(ColorMode colorMode) {
    _updatePdfColorModeState(colorMode);
    _savePdfColorMode(colorMode);
  }

  void _updatePdfColorModeState(ColorMode colorMode) {
    ref.read(pdfColorModeProvider.notifier).state = colorMode;
  }

  void _savePdfColorMode(ColorMode colorMode) {
    SharedPreferenceClient.pdfThemeModeIndex = colorMode.index;
  }

  void toggleFullScreenMode() {
    final screenMode = ref.read(fullScreenStateProvider);
    ref.read(fullScreenStateProvider.notifier).state = !screenMode;
  }

  Future<void> onPageChanged(
      {required String nsyBookId, required int pageIndex}) async {
    final recentRepo = ref.read(recentRepoProvider);
    final nsyBookRepo = ref.read(nsyBookRepoProvider);
    int firstPageOfNsy = await nsyBookRepo.getFirstPageNumber(nsyBookId: nsyBookId);
    int currentPageIndex = pageIndex;
    debugPrint('current page index: $currentPageIndex');
    if(currentPageIndex < firstPageOfNsy){
      currentPageIndex = firstPageOfNsy;
    }

    // int prePagesCount =
    //     await nsyBookRepo.getPrePagesCount(nsyBookId: nsyBookId);
    // debugPrint('pre pages count: $prePagesCount');
    // int curentPageNumber = currentPageIndex - prePagesCount;
    // debugPrint('current nsy pagenumber: $curentPageNumber');
    int? paliPageNumber;

    while (paliPageNumber == null && currentPageIndex >= firstPageOfNsy) {
      debugPrint('current pageIndex: $currentPageIndex');
      paliPageNumber = await nsyBookRepo.getPaliPageNumber(
          nsyBookId: nsyBookId, nsyPageNumber: currentPageIndex);
      currentPageIndex--;
    }

    debugPrint('pali page number: $paliPageNumber');

    final currentRecent = await recentRepo.getRecent(nsyId: nsyBookId);
    final newRecent = currentRecent.copyWith(
      paliPageNumber: paliPageNumber!,
      nsyPageNumber: pageIndex,
      dateTime: DateTime.now(),
    );
    EasyDebounce.debounce('recent', const Duration(seconds: 1), () {
      recentRepo.add(newRecent);
    });
  }
}

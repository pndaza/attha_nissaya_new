import 'package:attha_nissaya/models/recent.dart';
import 'package:attha_nissaya/repositories/database.dart';
import 'package:attha_nissaya/repositories/recent_repo.dart';
import 'package:attha_nissaya/screens/reader/reader_page.dart';
import 'package:attha_nissaya/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/error_view.dart';
import '../../../../widgets/loading_view.dart';
import 'recent_page_controller.dart';
import 'widgets/recent_list_view.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({Key? key}) : super(key: key);

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  late final RecentPageController viewController;

  @override
  void initState() {
    super.initState();
    viewController = RecentPageController(
      recentRepository: DatabaseRecentRepository(DatabaseHelper(), RecentDao()),
    );
    viewController.init();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: viewController.state,
        builder: (_, state, __) {
          if (state == RecentState.loading) {
            return const LoadingView();
          } else if (state == RecentState.error) {
            return const ErrorView();
          } else if (state == RecentState.empty) {
            return const EmpytView();
          }

          return RecentListView(
              recents: viewController.recents,
              onItemClicked: (recent) {
                debugPrint('${recent.nsyId} is clicked');

                context.goto(ReaderPage(
                  id: recent.nsyId,
                  name: recent.nsyName,
                  pageNumber: recent.nsyPageNumber,
                )).then((value) => refresh());
              },
              onItemDeleted: (recent) {
                viewController.onDeleted(recent);
              });
        });
  }

  void refresh() {
    setState(() {
      viewController.init();
      debugPrint('refresh page');
    });
  }
}

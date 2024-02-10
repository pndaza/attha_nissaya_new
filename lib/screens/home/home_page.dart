import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/navigation_helper.dart';
import '../../utils/platform_helper.dart';

import '../info/info_page.dart';
import 'home_view_controller.dart';
import 'sub_pages/book_list_page/book_list_page.dart';
import 'sub_pages/recent_page/recent_page.dart';

class NavDestination {
  final String label;
  final IconData iconData;
  NavDestination({
    required this.label,
    required this.iconData,
  });
}

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  final List<NavDestination> destinations = <NavDestination>[
    NavDestination(label: 'ပင်မ', iconData: Icons.home),
    NavDestination(label: 'ကြည့်ဆဲ', iconData: Icons.history),
  ];

  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final appBar = AppBar(
      title: const Text('အဋ္ဌကထာနိဿယ'),
      centerTitle: true,
      actions: _actionButtons(ref, themeMode),
    );

    return Scaffold(
      appBar: isMobile ? appBar : null,
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              elevation: 1,
              destinations: destinations
                  .map(
                    (destination) => NavigationRailDestination(
                        icon: Icon(
                          destination.iconData,
                        ),
                        label: Text(destination.label)),
                  )
                  .toList(),
              onDestinationSelected: _onDestinationSelected,
              selectedIndex: selectedIndex,
            ),
          Expanded(
              child: Column(
            children: [
              if (isDesktop) appBar,
              Expanded(
                child: PageView.builder(
                    controller: pageController,
                    itemCount: destinations.length,
                    itemBuilder: (_, index) {
                      late Widget page;
                      switch (index) {
                        case 1:
                          page = const RecentPage();
                          break;
                        default:
                          page = const BookListPage();
                      }
                      return page;
                    }),
              ),
            ],
          ))
        ],
      ),
      bottomNavigationBar: isMobile
          ? NavigationBarTheme(
              data: Theme.of(context).navigationBarTheme.copyWith(
                    labelTextStyle: MaterialStateProperty.resolveWith(
                      (states) => TextStyle(
                          fontSize: (16 * textScaleFactor).clamp(16.0, 18.0)),
                    ),
                  ),
              child: NavigationBar(
                destinations: destinations
                    .map(
                      (destination) => NavigationDestination(
                          icon: Icon(destination.iconData),
                          label: destination.label),
                    )
                    .toList(),
                onDestinationSelected: _onDestinationSelected,
                selectedIndex: selectedIndex,
              ),
            )
          : null,
    );
  }

  void _onDestinationSelected(int index) {
    if (isDesktop) {
      pageController.jumpToPage(index);
    } else {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _actionButtons(WidgetRef ref, ThemeMode themeMode) {
    return [
      PopupMenuButton<ThemeMode>(
        icon: const Icon(Icons.palette_outlined),
        initialValue: themeMode,
        offset: const Offset(0.0, 56.0),
        itemBuilder: (_) => [
          CheckedPopupMenuItem(
            padding: EdgeInsets.zero,
            checked: ThemeMode.light == themeMode,
            value: ThemeMode.light,
            child: const Text('နေ့'),
          ),
          CheckedPopupMenuItem(
            padding: EdgeInsets.zero,
            checked: ThemeMode.dark == themeMode,
            value: ThemeMode.dark,
            child: const Text('ည'),
          ),
          CheckedPopupMenuItem(
            padding: EdgeInsets.zero,
            checked: ThemeMode.system == themeMode,
            // padding: const EdgeInsets.only(left: 16),
            value: ThemeMode.system,
            child: const Text('စက်'),
          ),
        ],
        onSelected: (themeMode) {
          ref.read(homeViewController).changeThemeMode(themeMode);
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      IconButton(
          onPressed: () => context.goto(const InfoPage()),
          icon: const Icon(Icons.info_outlined))
    ];
  }
}

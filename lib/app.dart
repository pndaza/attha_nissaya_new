import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';

import 'deep_link_handler.dart';
import 'screens/home/home_page.dart';
import 'screens/home/home_view_controller.dart';
import 'screens/nsy_list/nsy_choice.dart';
import 'utils/platform_helper.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final DeepLinkHandler _mobileDeepLink;
  StreamSubscription<String>? _mobilelinkSubscription;
  StreamSubscription<Uri>? _desktoplinkSubscription;

  @override
  void initState() {
    super.initState();
    if (isMobile) {
      // _mobileDeepLinkBloc = DeepLinkHandler();
      initMobileDeepLinks();
    }
    if (isDesktop) {
      _handleIncomingLinks();
      _handleInitialUri();
    }
  }

  @override
  void dispose() {
    _mobilelinkSubscription?.cancel();
    _desktoplinkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attha Nissaya',
      theme: ThemeData(primarySwatch: Colors.pink),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      navigatorKey: _navigatorKey,
      home: const Home(),
    );
  }

  Future<void> initMobileDeepLinks() async {
    _mobileDeepLink = DeepLinkHandler();
    _mobilelinkSubscription = _mobileDeepLink.state.listen((uri) {
      debugPrint('onAppLink: $uri');
      openMobileAppLink(uri);
    });
  }

  void _handleIncomingLinks() {
    final appLinks = AppLinks();
    _desktoplinkSubscription = appLinks.uriLinkStream.listen((Uri uri) {
      debugPrint('onAppLink: $uri');
      openDesktopAppLink(uri);
    }, onError: (Object err) {
      debugPrint('link stream error: $err');
    });
  }

  Future<void> _handleInitialUri() async {
    final appLinks = AppLinks();
    try {
      final uri = await appLinks.getInitialLink();
      if (uri != null) {
        debugPrint('onAppLink: $uri');
        openDesktopAppLink(uri);
      }
    } on PlatformException {
      debugPrint('failed to get initial uri');
    } on FormatException catch (err) {
      debugPrint(err.toString());
    }
  }

  void openMobileAppLink(String url) {
    final paliBookId = parseBookId(url);
    final pageNumber = parsePageNumber(url);
    if (paliBookId != null && pageNumber != null) {
      final route = nsyChoiceRoute(
        paliBookId: paliBookId,
        pageNumber: int.parse(pageNumber),
      );
      _navigatorKey.currentState
          ?.pushAndRemoveUntil(route, (Route<dynamic> route) => false);
    }
  }

  void openDesktopAppLink(Uri uri) {
    final url = uri.toString();
    final paliBookId = parseBookId(url);
    final pageNumber = parsePageNumber(url);
    debugPrint(paliBookId);
    debugPrint(pageNumber);
    if (paliBookId != null && pageNumber != null) {
      // Todo: extract book name from db
      final route = nsyChoiceRoute(
        paliBookId: paliBookId,
        pageNumber: int.parse(pageNumber),
      );

      _navigatorKey.currentState
          ?.pushAndRemoveUntil(route, (Route<dynamic> route) => false);
    }
  }

  MaterialPageRoute nsyChoiceRoute(
      {required String paliBookId,
      required int pageNumber}) {
    return MaterialPageRoute(
      builder: (_) => NsyChoice(
        paliBookID: paliBookId,
        paliBookPageNumber: pageNumber,
        isOpenFromDeepLink: true,
      ),
    );
  }

  String? parseBookId(String url) {
    RegExp regexId = RegExp(r'\w+_\w+_\d+(_\d+)?');
    final matchId = regexId.firstMatch(url);
    return matchId?.group(0);
  }

  String? parsePageNumber(String url) {
    RegExp regexPage = RegExp(r'\d+$');
    final matchPage = regexPage.firstMatch(url);
    return matchPage?.group(0);
  }
}

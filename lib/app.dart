import 'package:attha_nissaya/screens/home/home_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'deep_link_handler.dart';
import 'deep_link_view.dart';
import 'screens/home/home_page.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _deepLinkBloc = DeepLinkHandler();

    final themeMode = ref.watch(themeProvider);
    print(themeMode);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atthakatha Nissaya',
      theme: ThemeData(primarySwatch: Colors.pink),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: StreamBuilder<String>(
          stream: _deepLinkBloc.state,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              debugPrint(snapshot.data);
              debugPrint('opening from deep link');
              return DeepLinkView(
                  key: Key(snapshot.data!), url: snapshot.data!);
            } else {
              return const Home();
            }
          }),
    );
  }
}

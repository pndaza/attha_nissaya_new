import 'package:flutter/material.dart';

import 'deep_link_handler.dart';
import 'deep_link_view.dart';
import 'screens/home/home_page.dart'; 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deepLinkBloc = DeepLinkHandler();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atthakatha Nissaya',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: StreamBuilder<String>(
          stream: _deepLinkBloc.state,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              debugPrint(snapshot.data);
              debugPrint('opening from deep link');
              return DeepLinkView(key: Key(snapshot.data!), url: snapshot.data!);
            } else {
              return const Home();
            }
          }),
    );
  }
}

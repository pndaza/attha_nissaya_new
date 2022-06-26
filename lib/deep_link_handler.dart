import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

// final deepLinkProvider = Provider.autoDispose((ref) {
//   final deepLinkHandler = DeepLinkHandler();
//   ref.onDispose(() => deepLinkHandler.dispose());
//   return deepLinkHandler;
// });

class DeepLinkHandler {
  //Event Channel creation
  static const stream = EventChannel('mm.pndaza.atthanissaya/events');

  //Method channel creation
  static const platform = MethodChannel('mm.pndaza.atthanissaya/channel');

  final StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  //Adding the listener into contructor
  DeepLinkHandler() {
    //Checking application start by deep link
    startUri().then(_onRedirected);
    //Checking broadcast stream, if deep link was clicked in opened appication
    stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
  }

  _onRedirected(String uri) {
    // Here can be any uri analysis, checking tokens etc, if it’s necessary
    // Throw deep link URI into the BloC's stream
    stateSink.add(uri);
  }

  void dispose() {
    _stateController.close();
  }

  Future<String> startUri() async {
    if (Platform.isWindows) return 'not support now';

    try {
      final initialLink = await platform.invokeMethod('initialLink') as String;
      // print('initialLink: $initialLink');
      return initialLink;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}

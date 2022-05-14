import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'app.dart';
import 'client/shared_pref_client.dart';

final myLogger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferenceClient.init();

  runApp(const ProviderScope(child: MyApp()));
}

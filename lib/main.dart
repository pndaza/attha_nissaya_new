import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uni_links_desktop/uni_links_desktop.dart';

import 'dart:io' show Platform;
import 'app.dart';
import 'client/shared_pref_client.dart';

final myLogger = Logger();

Future<void> main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();

    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    registerProtocol('atthanissaya');
  }

  await SharedPreferenceClient.init();

  runApp(const ProviderScope(child: MyApp()));
}

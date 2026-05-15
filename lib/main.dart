import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';
import 'client/shared_pref_client.dart';
import 'utils/window_config.dart';

final myLogger = Logger();

const _defaultSize = Size(800, 600);
const _minSize = Size(400, 300);

Future<void> main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();

    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferenceClient.init();

  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    final windowConfig = await WindowConfig.loadWindowConfig();
    await windowManager.ensureInitialized();

    final double? left = windowConfig?['left'];
    final double? top = windowConfig?['top'];
    final double? width = windowConfig?['width'];
    final double? height = windowConfig?['height'];
    final bool isMaximized = windowConfig?['isMaximized'] == 1.0;

    Size size;
    bool center;
    if (width != null && height != null) {
      size = Size(width, height);
      center = (left == null || top == null);
    } else {
      size = _defaultSize;
      center = true;
    }

    WindowOptions windowOptions = WindowOptions(
      size: size,
      center: center,
      minimumSize: _minSize,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      if (isMaximized) {
        await windowManager.maximize();
      } else if (left != null && top != null && width != null && height != null) {
        await windowManager.setBounds(Rect.fromLTWH(left, top, width, height));
      }

      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const ProviderScope(child: MyApp()));
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

abstract class WindowConfig {
  static const String _fileName = 'window_config.json';

  static Future<Map<String, double>?> loadWindowConfig() async {
    try {
      final directory = await getApplicationSupportDirectory();
      final file = File('${directory.path}/$_fileName');

      if (await file.exists()) {
        final jsonString = await file.readAsString();
        return Map<String, double>.from(jsonDecode(jsonString));
      }
    } catch (e) {
      debugPrint('Error loading window config: $e');
    }
    return null;
  }

  static Future<void> saveWindowConfig(Map<String, double> config) async {
    try {
      final directory = await getApplicationSupportDirectory();
      await directory.create(recursive: true);
      final file = File('${directory.path}/$_fileName');
      final jsonString = jsonEncode(config);
      await file.writeAsString(jsonString);
    } catch (e) {
      debugPrint('Error saving window config: $e');
    }
  }
}

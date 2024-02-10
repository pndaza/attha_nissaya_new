import 'package:flutter/material.dart';

extension NavigationHelperExtension on BuildContext {
  /// Navigate to page
  Future<void> goto(Widget page) async {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }
}

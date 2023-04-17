import 'package:flutter/material.dart' show debugPrint;

class Logger {
  static void log(String data, {bool showPadding = false}) {
    if (showPadding) {
      debugPrint("\n");
    }
    debugPrint(data);
    if (showPadding) {
      debugPrint("\n");
    }
  }

  static void logWithTag(String tag, String data, {bool showPadding = false}) {
    if (showPadding) {
      debugPrint("\n");
    }
    debugPrint("$tag:");
    debugPrint(data);
    if (showPadding) {
      debugPrint("\n");
    }
  }
}

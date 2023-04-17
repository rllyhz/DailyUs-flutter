import 'package:flutter/material.dart' show debugPrint;

class Logger {
  void log(String data, {bool showPadding = false}) {
    if (showPadding) {
      debugPrint("\n");
    }
    debugPrint(data);
    if (showPadding) {
      debugPrint("\n");
    }
  }

  void logWithTag(String tag, String data, {bool showPadding = false}) {
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

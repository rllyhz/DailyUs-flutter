import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;

class Logger {
  static void log(String data, {bool showPadding = false}) {
    if (!kDebugMode) {
      return;
    }

    if (showPadding) {
      debugPrint("\n");
    }
    debugPrint(data);
    if (showPadding) {
      debugPrint("\n");
    }
  }

  static void logWithTag(String tag, String data, {bool showPadding = false}) {
    if (!kDebugMode) {
      return;
    }

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

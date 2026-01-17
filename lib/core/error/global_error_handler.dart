import 'package:flutter/foundation.dart';

class GlobalErrorHandler {
  static void report({
    required Object error,
    StackTrace? stackTrace,
    String? context,
  }) {
    // DEV logging
    if (kDebugMode) {
      debugPrint('--- GLOBAL ERROR ---');
      if (context != null) debugPrint('Context: $context');
      debugPrint(error.toString());
      if (stackTrace != null) debugPrint(stackTrace.toString());
    }
  }
}

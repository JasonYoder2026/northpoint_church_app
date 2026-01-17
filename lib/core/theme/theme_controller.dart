import 'package:flutter_riverpod/legacy.dart';

enum AppThemeMode { system, light, dark }

class ThemeController extends StateNotifier<AppThemeMode> {
  ThemeController() : super(AppThemeMode.system);

  void setTheme(AppThemeMode mode) {
    state = mode;
    // Optional: persist to shared_preferences
  }

  void toggleNext() {
    // cycle through the three options
    switch (state) {
      case AppThemeMode.system:
        state = AppThemeMode.light;
        break;
      case AppThemeMode.light:
        state = AppThemeMode.dark;
        break;
      case AppThemeMode.dark:
        state = AppThemeMode.system;
        break;
    }
  }
}

final themeControllerProvider =
    StateNotifierProvider<ThemeController, AppThemeMode>(
      (ref) => ThemeController(),
    );

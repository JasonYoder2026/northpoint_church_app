import 'package:flutter/material.dart';
import 'package:northpoint_church_app/features/splash/splash_page.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NorthPoint Church Muncie',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}

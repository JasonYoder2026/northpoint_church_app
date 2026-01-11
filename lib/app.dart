import 'package:flutter/material.dart';
import 'package:northpoint_church_app/core/routing/app_router.dart';
import 'package:northpoint_church_app/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, 
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,);
  }
}

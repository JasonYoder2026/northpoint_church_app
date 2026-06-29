import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'package:northpoint_church_app/core/theme/theme_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/services/message_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final getIt = GetIt.instance;

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();

    if (!getIt.isRegistered<MessageHandler>()) {
      getIt.registerSingleton(MessageHandler(router));
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      getIt<MessageHandler>().handle(message.data);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        getIt<MessageHandler>().handle(message.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'NorthPoint Church Muncie',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: switch (themeMode) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      },
    );
  }
}

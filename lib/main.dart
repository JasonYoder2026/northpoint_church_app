import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/app.dart';
import 'package:northpoint_church_app/core/error/global_error_handler.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'core/services/supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  await setupDependencies();
  FlutterError.onError = (details) {
    GlobalErrorHandler.report(
      error: details.exception,
      stackTrace: details.stack,
      context: "FlutterError",
    );
  };
  runApp(const ProviderScope(child: App()));
}

Future<void> setupDependencies() async {
  /// Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_PUBLISHABLE']!,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    print('APNS TOKEN: $apnsToken');
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("TOKEN: ${fcmToken.toString()}");
    if (fcmToken != null) {
      await FirebaseMessaging.instance.subscribeToTopic('all_users');
    }
    FirebaseMessaging.onMessage.listen((message) {
      print('Received message: ${message.notification?.title}');
    });
  }

  final supabase = Supabase.instance.client;

  getIt.registerSingleton<SupabaseProvider>(SupabaseService(client: supabase));
}

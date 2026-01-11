import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/app.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'core/services/supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDependencies();
  runApp(const ProviderScope(child: App()));
}

Future<void> setupDependencies() async {
  /// Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_PUBLISHABLE']!,
  );

  final supabase = Supabase.instance.client;

  getIt.registerSingleton<SupabaseProvider>(SupabaseService(client: supabase));
}

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  /// Initialize Supabase
  static Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_PUBLISHABLE']!,
    );
  }

  /// Restore session if there is one
  Future<void> restoreSession() async {
    final session = Supabase.instance.client.auth.currentSession;
  }
}

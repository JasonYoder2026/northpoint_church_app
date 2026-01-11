import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';

class SupabaseService extends SupabaseProvider {
  final SupabaseClient client;

  SupabaseService({required this.client});

  @override
  Future<SupabaseClient?> getCurrentSession() async {
    return client;
  }

  @override
  Future<String?> getCurrentToken() async {
    final session = client.auth.currentSession;
    return session?.accessToken;
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseProvider {
  Future<SupabaseClient?> getCurrentSession();
  Future<String?> getCurrentToken();
  Future<void> signOut() async {}
}

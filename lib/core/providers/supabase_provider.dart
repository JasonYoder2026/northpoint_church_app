import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';

abstract class SupabaseProvider {
  Future<SupabaseClient?> getCurrentSession();
  Future<String?> getCurrentToken();
  Future<void> signOut() async {}
  Future<AuthenticationResponses> signIn({
    required String email,
    required String password,
  });
  Future<void> restoreSession() async {}
  Future<AuthenticationResponses> signup({
    required String name,
    required String email,
    required String password,
  });
}

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';

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
  Future<AuthenticationResponses> signIn({
    required String email,
    required String password,
  }) async {
    final AuthResponse response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user != null) {
      return AuthenticationResponses.success;
    }
    return AuthenticationResponses.failure;
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client;

  AuthService(this._client);

  Future<void> restoreSession() async {
    await _client.auth.currentSession;
  }
}

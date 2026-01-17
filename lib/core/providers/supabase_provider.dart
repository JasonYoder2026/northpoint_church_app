import 'package:northpoint_church_app/core/config/signup_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'dart:io';

abstract class SupabaseProvider {
  Future<SupabaseClient?> getCurrentSession();
  Future<String?> getCurrentToken();
  Future<User> currentUser();
  Future<void> signOut() async {}
  Future<AuthenticationResponses> signIn({
    required String email,
    required String password,
  });
  Future<void> restoreSession() async {}
  Future<SignupResult> signup({
    required String name,
    required String email,
    required String password,
  });
  Future<String> uploadAvatar(String userId, File image);
  Future<void> saveAvatarUrl(String url);
  Future<Map<String, dynamic>> getUserProfile(String userId);
  Future<String?> getAvatarUrl(String path);
}

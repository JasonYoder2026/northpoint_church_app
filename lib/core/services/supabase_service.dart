import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'package:northpoint_church_app/core/config/signup_result.dart';
import 'package:northpoint_church_app/core/services/password_validator.dart';
import 'dart:io';

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

  @override
  Future<void> restoreSession() async {
    await client.auth.refreshSession();
  }

  @override
  Future<SignupResult> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final passwordCheck = validatePassword(password);
    if (passwordCheck != AuthenticationResponses.success) {
      return SignupResult(status: passwordCheck);
    }

    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'Display name': name},
    );

    if (response.user == null) {
      return SignupResult(status: AuthenticationResponses.failure);
    }

    final user = response.user!;

    if (response.session == null) {
      return SignupResult(
        status: AuthenticationResponses.emailNotVerified,
        user: user,
      );
    }

    await client.from("Users").insert({
      'id': user.id,
      'Name': name,
      'Email': email,
    });
    return SignupResult(status: AuthenticationResponses.success, user: user);
  }

  @override
  Future<String> uploadAvatar(String userId, File image) async {
    final path = '$userId/avatar.jpg';

    await client.storage
        .from('avatars')
        .upload(path, image, fileOptions: const FileOptions(upsert: true));

    return client.storage.from('avatars').getPublicUrl(path);
  }

  @override
  Future<void> saveAvatarUrl(String url) async {
    final userId = client.auth.currentUser!.id;

    await client.from('Users').update({'Avatar_URL': url}).eq('id', userId);
  }
}

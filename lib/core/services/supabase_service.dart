import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'package:image_picker/image_picker.dart';

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
  Future<AuthenticationResponses> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final AuthResponse response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'Display name': name},
    );

    final user = client.auth.currentUser;

    final UserResponse = await client.from("Users").insert({
      'id': user?.id,
      'Name': name,
      'Email': email,
    });

    final user1 = response.user;

    if (user1 != null && UserResponse != null) {
      return AuthenticationResponses.success;
    }
    return AuthenticationResponses.failure;
  }

  @override
  Future<String> uploadAvatar(XFile image) async {
    final userId = client.auth.currentUser!.id;
    final bytes = await image.readAsBytes();

    final path = '$userId/avatar.jpg';

    await client.storage
        .from('avatars')
        .uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/jpeg',
          ),
        );

    return client.storage.from('avatars').getPublicUrl(path);
  }

  @override
  Future<void> saveAvatarUrl(String url) async {
    final userId = client.auth.currentUser!.id;

    await client.from('Users').update({'Avatar_URL': url}).eq('id', userId);
  }
}

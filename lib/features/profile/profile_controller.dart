import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../core/providers/supabase_provider.dart';

class ProfileState {
  final String? name;
  final String? email;
  final String? avatarUrl;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.name,
    this.email,
    this.avatarUrl,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  final supabase = GetIt.instance<SupabaseProvider>();

  @override
  ProfileState build() => const ProfileState(isLoading: true);

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true);

    try {
      final user = await supabase.currentUser();

      final response = await supabase.getUserProfile(user.id);

      state = state.copyWith(
        name: response['Name'] as String?,
        email: response['Email'] as String?,
        //avatarUrl: response['AvatarUrl'] as String?, // if you store avatar in table
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> signOut() async {
    await supabase.signOut();
  }
}

final profileControllerProvider =
    NotifierProvider<ProfileController, ProfileState>(ProfileController.new);

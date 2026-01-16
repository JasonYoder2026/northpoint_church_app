import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'package:northpoint_church_app/core/services/image_picker.dart';

enum SignupStatus { idle, loading, success, error }

// Create a state class that holds all signup-related data
class SignupState {
  final SignupStatus status;
  final String? errorMessage;
  final String? avatarUrl;
  final bool isUploadingAvatar;
  final XFile? pickedImage;

  const SignupState({
    this.status = SignupStatus.idle,
    this.errorMessage,
    this.avatarUrl,
    this.isUploadingAvatar = false,
    this.pickedImage,
  });

  SignupState copyWith({
    SignupStatus? status,
    String? errorMessage,
    String? avatarUrl,
    bool? isUploadingAvatar,
    XFile? pickedImage,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isUploadingAvatar: isUploadingAvatar ?? this.isUploadingAvatar,
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }
}

class SignupController extends Notifier<SignupState> {
  @override
  SignupState build() => const SignupState();

  Future<void> pickAvatar() async {
    try {
      final image = await pickAvatarImage();
      if (image == null) return;

      state = state.copyWith(pickedImage: image);
    } catch (e) {
      state = state.copyWith(
        isUploadingAvatar: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> signup(String name, String email, String password) async {
    state = state.copyWith(status: SignupStatus.loading, errorMessage: null);

    final supabase = GetIt.instance<SupabaseProvider>();

    try {
      //1) create user account
      final response = await supabase.signup(
        name: name,
        email: email,
        password: password,
      );

      print("Signup response: " + response.toString());

      if (response == AuthenticationResponses.success) {
        state = state.copyWith(status: SignupStatus.success);
      } else {
        state = state.copyWith(
          status: SignupStatus.error,
          errorMessage: 'Failed creating account. Internal server error.',
        );
      }

      // 2) upload image if picked
      String? avatarUrl;
      if (state.pickedImage != null) {
        state = state.copyWith(isUploadingAvatar: true);
        avatarUrl = await supabase.uploadAvatar(state.pickedImage!);
        state = state.copyWith(isUploadingAvatar: false, avatarUrl: avatarUrl);
      }
      state = state.copyWith(status: SignupStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: SignupStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}

final signupControllerProvider =
    NotifierProvider<SignupController, SignupState>(SignupController.new);

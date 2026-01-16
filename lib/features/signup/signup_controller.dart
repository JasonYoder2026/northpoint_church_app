import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'package:northpoint_church_app/core/services/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

enum SignupStatus { idle, loading, success, error }

// Create a state class that holds all signup-related data
class SignupState {
  final SignupStatus status;
  final String? errorMessage;
  final String? avatarUrl;
  final bool isUploadingAvatar;
  final XFile? pickedImage;
  final bool isLoading;
  final String? authError;

  const SignupState({
    this.status = SignupStatus.idle,
    this.errorMessage,
    this.avatarUrl,
    this.isUploadingAvatar = false,
    this.pickedImage,
    this.isLoading = false,
    this.authError,
  });

  SignupState copyWith({
    SignupStatus? status,
    String? errorMessage,
    String? avatarUrl,
    bool? isUploadingAvatar,
    XFile? pickedImage,
    bool? isLoading,
    String? authError,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isUploadingAvatar: isUploadingAvatar ?? this.isUploadingAvatar,
      pickedImage: pickedImage ?? this.pickedImage,
      isLoading: isLoading ?? this.isLoading,
      authError: authError ?? this.authError,
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

      if (response.status != AuthenticationResponses.success) {
        state = state.copyWith(
          status: SignupStatus.error,
          errorMessage: _mapSignupEnumToMessage(response.status),
        );
        return;
      }
      final user = response.user!;

      // 2) upload image if picked
      String? avatarUrl;
      if (state.pickedImage != null) {
        state = state.copyWith(isUploadingAvatar: true);
        File image = File(state.pickedImage!.path);
        avatarUrl = await supabase.uploadAvatar(user.id, image);
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

  String _mapSignupEnumToMessage(AuthenticationResponses status) {
    switch (status) {
      case AuthenticationResponses.noSpecialCharacter:
        return 'Password must contain a special character';
      case AuthenticationResponses.noDigit:
        return 'Password must contain a number';
      case AuthenticationResponses.noUppercase:
        return 'Password must contain an uppercase letter';
      case AuthenticationResponses.lessThanMinLength:
        return 'Password is too short';
      case AuthenticationResponses.emailNotVerified:
        return 'Please verify your email before signing in';
      case AuthenticationResponses.failure:
        return 'Signup failed. Please try again.';
      default:
        return 'An unexpected error occurred';
    }
  }

  String mapPasswordError(AuthenticationResponses status) {
    switch (status) {
      case AuthenticationResponses.lessThanMinLength:
        return 'Password must be at least 8 characters';
      case AuthenticationResponses.noUppercase:
        return 'Password must contain an uppercase letter';
      case AuthenticationResponses.noDigit:
        return 'Password must contain a number';
      case AuthenticationResponses.noSpecialCharacter:
        return 'Password must contain a special character';
      case AuthenticationResponses.invalidSpecialCharacter:
        return 'Password contains invalid characters';
      default:
        return 'Invalid password';
    }
  }
}

final signupControllerProvider =
    NotifierProvider<SignupController, SignupState>(SignupController.new);

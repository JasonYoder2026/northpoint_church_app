import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'package:northpoint_church_app/core/services/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/error/global_error_handler.dart';

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
    } catch (e, stack) {
      GlobalErrorHandler.report(
        error: e,
        stackTrace: stack,
        context: 'SignupController.pickAvatar',
      );

      state = state.copyWith(
        errorMessage: 'Could not pick image. Please try again.',
      );
    }
  }

  Future<void> signup(String name, String email, String password) async {
    state = state.copyWith(status: SignupStatus.loading, errorMessage: null);

    final supabase = GetIt.instance<SupabaseProvider>();

    try {
      // 1️⃣ Create account
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

      // 2️⃣ Upload avatar (NON-FATAL)
      if (state.pickedImage != null) {
        try {
          state = state.copyWith(isUploadingAvatar: true);

          final file = File(state.pickedImage!.path);
          final avatarUrl = await supabase.uploadAvatar(user.id, file);

          state = state.copyWith(
            avatarUrl: avatarUrl,
            isUploadingAvatar: false,
          );
        } catch (e, stack) {
          // Avatar upload failure should NOT fail signup
          GlobalErrorHandler.report(
            error: e,
            stackTrace: stack,
            context: 'SignupController.uploadAvatar',
          );

          state = state.copyWith(isUploadingAvatar: false);
        }
      }

      // 3️⃣ Success
      state = state.copyWith(status: SignupStatus.success);
    } on AuthException catch (e) {
      state = state.copyWith(
        status: SignupStatus.error,
        errorMessage: _mapAuthError(e),
      );
    } catch (e, stack) {
      GlobalErrorHandler.report(
        error: e,
        stackTrace: stack,
        context: 'SignupController.signup',
      );

      state = state.copyWith(
        status: SignupStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  String _mapAuthError(AuthException e) {
    switch (e.message) {
      case 'User already registered':
        return 'An account already exists for this email.';
      case 'Password should be at least 6 characters':
        return 'Password is too short.';
      default:
        return 'Signup failed. Please try again.';
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

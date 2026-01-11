import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';

enum SignupStatus { idle, loading, success, error }

class SignupController extends Notifier<SignupStatus> {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  @override
  SignupStatus build() => SignupStatus.idle;

  /// Signup with email & password
  Future<void> signup(String name, String email, String password) async {
    state = SignupStatus.loading;
    final supabase = GetIt.instance<SupabaseProvider>();

    try {
      final response = await supabase.signup(
        name: name,
        email: email,
        password: password,
      );

      if (response == AuthenticationResponses.success) {
        state = SignupStatus.success;
      } else {
        _errorMessage = 'Invalid email or password';
        state = SignupStatus.error;
      }
    } catch (e) {
      _errorMessage = e.toString();
      state = SignupStatus.error;
    }
  }
}

final signupControllerProvider =
    NotifierProvider<SignupController, SignupStatus>(SignupController.new);

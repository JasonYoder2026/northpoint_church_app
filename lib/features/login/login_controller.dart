import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';

enum LoginStatus { idle, loading, success, error }

class LoginController extends Notifier<LoginStatus> {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  @override
  LoginStatus build() => LoginStatus.idle;

  /// Login with email & password
  Future<void> login(String email, String password) async {
    state = LoginStatus.loading;

    final supabase = GetIt.instance<SupabaseProvider>();

    try {
      final response = await supabase.signIn(email: email, password: password);

      if (response == AuthenticationResponses.success) {
        state = LoginStatus.success;
      } else {
        _errorMessage = 'Invalid email or password';
        state = LoginStatus.error;
      }
    } catch (e) {
      _errorMessage = e.toString();
      state = LoginStatus.error;
    }
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginStatus>(
  LoginController.new,
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:northpoint_church_app/core/config/auth_enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:northpoint_church_app/core/error/global_error_handler.dart';

enum LoginStatus { idle, loading, success, error }

class LoginController extends Notifier<LoginStatus> {
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  @override
  LoginStatus build() => LoginStatus.idle;

  /// Login with email & password
  Future<void> login(String email, String password) async {
    state = LoginStatus.loading;
    _errorMessage = null;

    final supabase = GetIt.instance<SupabaseProvider>();

    try {
      final response = await supabase.signIn(email: email, password: password);

      if (response == AuthenticationResponses.success) {
        state = LoginStatus.success;
      } else {
        _errorMessage = 'Invalid email or password';
        state = LoginStatus.error;
      }
    } on AuthException catch (e) {
      _errorMessage = _mapAuthError(e);
      state = LoginStatus.error;
    } catch (e, stack) {
      GlobalErrorHandler.report(
        error: e,
        stackTrace: stack,
        context: 'LoginController.login',
      );

      _errorMessage = 'Something went wrong. Please try again.';
      state = LoginStatus.error;
    }
  }

  String _mapAuthError(AuthException e) {
    switch (e.message) {
      case 'Invalid login credentials':
        return 'Incorrect email or password.';
      case 'Email not confirmed':
        return 'Please verify your email before logging in.';
      default:
        return 'Login failed. Please try again.';
    }
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginStatus>(
  LoginController.new,
);

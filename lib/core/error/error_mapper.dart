import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorMapper {
  static String auth(AuthException e) {
    switch (e.message) {
      case 'Invalid login credentials':
        return 'Incorrect email or password.';
      case 'Email not confirmed':
        return 'Please verify your email address.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}

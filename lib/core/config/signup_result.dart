import 'package:supabase/supabase.dart';
import 'auth_enum.dart';

class SignupResult {
  final AuthenticationResponses status;
  final User? user;

  SignupResult({required this.status, this.user});
}

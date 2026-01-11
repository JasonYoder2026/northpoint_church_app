import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';
import 'planning_center_service.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authServiceProvider = Provider<AuthService>((ref) {
  final client = ref.read(supabaseProvider);
  return AuthService(client);
});

final planningCenterProvider = Provider<PlanningCenterService>((ref) {
  return PlanningCenterService();
});

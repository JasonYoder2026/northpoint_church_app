import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// What the splash screen can decide
enum SplashStatus { loading, authenticated, unauthenticated }

class SplashController extends Notifier<SplashStatus> {
  @override
  SplashStatus build() {
    _checkSession();
    return SplashStatus.loading;
  }

  Future<void> _checkSession() async {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;

    if (session == null) {
      state = SplashStatus.unauthenticated;
      return;
    }

    // Supabase expiresAt is UNIX seconds
    final expiresAt = DateTime.fromMillisecondsSinceEpoch(
      session.expiresAt! * 1000,
    );

    final isExpired = DateTime.now().isAfter(expiresAt);

    if (isExpired) {
      await supabase.auth.signOut();
      state = SplashStatus.unauthenticated;
    } else {
      state = SplashStatus.authenticated;
    }
  }
}

/// Riverpod 3 provider
final splashControllerProvider =
    NotifierProvider<SplashController, SplashStatus>(SplashController.new);

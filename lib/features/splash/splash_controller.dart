import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jwt_decode/jwt_decode.dart';

/// What the splash screen can decide
enum SplashStatus { loading, authenticated, unauthenticated }

class SplashController extends Notifier<SplashStatus> {
  @override
  SplashStatus build() {
    // Trigger check immediately when provider is first read
    Future.microtask(() => checkSession());
    return SplashStatus.loading;
  }

  Future<void> checkSession() async {
    final supabase = GetIt.instance<SupabaseProvider>();
    final SupabaseClient? session = await supabase.getCurrentSession();

    if (session == null) {
      state = SplashStatus.unauthenticated;
      return;
    }

    final accessToken = await supabase.getCurrentToken();
    if (accessToken == null || accessToken.isEmpty) {
      state = SplashStatus.unauthenticated;
      return;
    }

    try {
      final payload = Jwt.parseJwt(accessToken);
      final exp = payload['exp']; // seconds since epoch
      final expiresAt = DateTime.fromMillisecondsSinceEpoch(exp * 1000);

      final isExpired = DateTime.now().isAfter(expiresAt);

      if (isExpired) {
        // log out if expired
        await supabase.signOut();
        state = SplashStatus.unauthenticated;
        return;
      } else {
        state = SplashStatus.authenticated;
        return;
      }
    } catch (e) {
      // token invalid or parse failed
      state = SplashStatus.unauthenticated;
      return;
    }
  }
}

/// Riverpod 3 provider
final splashControllerProvider =
    NotifierProvider.autoDispose<SplashController, SplashStatus>(
      SplashController.new,
    );

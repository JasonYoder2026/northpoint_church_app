import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
//import 'package:jwt_decode/jwt_decode.dart';
//import 'package:northpoint_church_app/core/error/global_error_handler.dart';
import 'splash_state.dart';

/// What the splash screen can decide
//enum SplashStatus { loading, authenticated, unauthenticated }

class SplashController extends Notifier<SplashState> {
  final supabase = GetIt.instance<SupabaseProvider>();
  @override
  SplashState build() {
    // Trigger check immediately when provider is first read
    //Future.microtask(() => checkSession());
    Future.microtask(() => initialize());
    return const SplashState(progress: 0, status: SplashStatus.loading);
  }

  Future<void> initialize() async {
    try {
      // Step 1 — Ensure Supabase client exists
      state = state.copyWith(progress: 0.2);

      await supabase.getCurrentSession();

      await supabase.fetchNumberOfEvents(1);

      state = state.copyWith(progress: 0.5);

      // Step 3 — Preload initial data (optional)
      await supabase.fetchNumberOfEvents(10);

      state = state.copyWith(progress: 0.8);

      await Future.delayed(const Duration(milliseconds: 200));

      state = state.copyWith(progress: 1, status: SplashStatus.ready);
    } catch (e) {
      state = state.copyWith(status: SplashStatus.error);
    }
  }
}

//   Future<void> checkSession() async {
//     final supabase = GetIt.instance<SupabaseProvider>();

//     try {
//       final SupabaseClient? session = await supabase.getCurrentSession();

//       if (session == null) {
//         state = SplashStatus.unauthenticated;
//         return;
//       }

//       final accessToken = await supabase.getCurrentToken();
//       if (accessToken == null || accessToken.isEmpty) {
//         state = SplashStatus.unauthenticated;
//         return;
//       }
//       final payload = Jwt.parseJwt(accessToken);
//       final exp = payload['exp']; // seconds since epoch
//       final expiresAt = DateTime.fromMillisecondsSinceEpoch(exp * 1000);

//       final isExpired = DateTime.now().isAfter(expiresAt);

//       if (isExpired) {
//         // log out if expired
//         await supabase.signOut();
//         state = SplashStatus.unauthenticated;
//         return;
//       } else {
//         state = SplashStatus.authenticated;
//         return;
//       }
//     } on FormatException catch (_) {
//       state = SplashStatus.unauthenticated;
//     } on AuthException catch (_) {
//       state = SplashStatus.unauthenticated;
//     } catch (e, stack) {
//       GlobalErrorHandler.report(
//         error: e,
//         stackTrace: stack,
//         context: 'SplashController.checkSession',
//       );

//       state = SplashStatus.unauthenticated;
//       return;
//     }
//   }
//}

/// Riverpod 3 provider
final splashControllerProvider =
    NotifierProvider.autoDispose<SplashController, SplashState>(
      SplashController.new,
    );

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/features/splash/splash_controller.dart';
import '../../core/theme/colors.dart';
import 'widgets/logo.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SplashStatus>(splashControllerProvider, (prev, next) {
      if (next == SplashStatus.authenticated) {
        context.go('/home');
      }

      if (next == SplashStatus.unauthenticated) {
        context.go('/login');
      }
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: const Center(child: LogoWidget()),
    );
  }
}

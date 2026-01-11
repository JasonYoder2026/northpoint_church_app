import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/features/splash/splash_controller.dart';
import '../../core/theme/colors.dart';
import 'widgets/logo.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() {
    // Trigger your SplashController to check session
    ref.read(splashControllerProvider.notifier).checkSession();
  }

  @override
  Widget build(BuildContext context) {
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

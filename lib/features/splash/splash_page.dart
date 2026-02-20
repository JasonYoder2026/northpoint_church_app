import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/features/splash/splash_controller.dart';
import 'package:go_router/go_router.dart';
import 'splash_state.dart';
import 'dart:math';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    ref.listen<SplashState>(splashControllerProvider, (prev, next) {
      if (next.status == SplashStatus.ready) {
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashState = ref.watch(splashControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Animated Logo
            AnimatedBuilder(
              animation: _spinController,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateY(_spinController.value * 2 * pi),
                  child: child,
                );
              },
              child: Image.asset('assets/images/logo.png', width: 120),
            ),

            const SizedBox(height: 40),

            /// Smooth Animated Progress Bar
            SizedBox(
              width: 240,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: splashState.progress),
                duration: const Duration(milliseconds: 400),
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            if (splashState.status == SplashStatus.error)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    ref.invalidate(splashControllerProvider);
                  },
                  child: const Text("Retry"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

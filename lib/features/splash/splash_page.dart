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
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _verticalAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _verticalAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -40.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -40.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_animationController);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 50),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashState = ref.watch(splashControllerProvider);

    ref.listen<SplashState>(splashControllerProvider, (prev, next) {
      if (next.status == SplashStatus.ready) {
        context.go('/home');
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _verticalAnimation.value),
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  ),
                );
              },
              child: Image.asset('assets/images/logo.png', width: 120),
            ),

            const SizedBox(height: 24),

            const Text(
              "NorthPoint Muncie",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: 240,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: splashState.progress),
                duration: const Duration(milliseconds: 400),
                builder: (context, value, _) {
                  return LinearProgressIndicator(value: value, minHeight: 6);
                },
              ),
            ),

            const SizedBox(height: 16),

            Text(
              splashState.message ?? "",
              style: const TextStyle(fontSize: 14),
            ),

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

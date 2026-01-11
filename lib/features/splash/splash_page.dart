import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import 'widgets/logo.dart';
import '../home/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Simulate initialization work
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Navigate to HomePage
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: const Center(child: LogoWidget()),
    );
  }
}

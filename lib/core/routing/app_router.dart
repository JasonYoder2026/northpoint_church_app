import 'package:go_router/go_router.dart';
import 'package:northpoint_church_app/features/home/home_page.dart';
import 'package:northpoint_church_app/features/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
  ],
);

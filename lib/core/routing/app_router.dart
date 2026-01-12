import 'package:go_router/go_router.dart';
import 'package:northpoint_church_app/features/splash/splash_page.dart';
import 'package:northpoint_church_app/features/home/home.dart';
import 'package:northpoint_church_app/features/login/login.dart';
import 'package:northpoint_church_app/features/signup/signup.dart';
import 'transitions.dart';

GoRouter router() => GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/signup",
      name: "signup",
      pageBuilder: (context, state) {
        return slideFromRight(child: const SignupPage());
      },
    ),
  ],
);

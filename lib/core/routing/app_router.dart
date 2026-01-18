import 'package:go_router/go_router.dart';
import 'package:northpoint_church_app/features/splash/splash_page.dart';
import 'package:northpoint_church_app/features/home/home.dart';
import 'package:northpoint_church_app/features/login/login.dart';
import 'package:northpoint_church_app/features/signup/signup.dart';
import 'package:northpoint_church_app/features/profile/profile.dart';
import 'package:northpoint_church_app/features/tithe/tithe.dart';
import 'transitions.dart';
import 'package:northpoint_church_app/features/help/help.dart';
import 'package:northpoint_church_app/features/privacy/privacy.dart';
import 'package:northpoint_church_app/features/terms/terms.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/privacy',
      name: 'privacy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) {
        return slideFromRight(child: const LoginPage());
      },
    ),
    GoRoute(
      path: "/signup",
      name: "signup",
      pageBuilder: (context, state) {
        return slideFromRight(child: const SignupPage());
      },
    ),
    GoRoute(
      path: '/help',
      name: 'help',
      builder: (context, state) => const HelpPage(),
    ),
    GoRoute(
      path: '/tithe',
      name: 'tithe',
      builder: (context, state) => TithePage(),
    ),
    GoRoute(path: '/home', name: 'home', builder: (_, __) => const HomePage()),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (_, __) => ProfilePage(),
    ),
  ],
);

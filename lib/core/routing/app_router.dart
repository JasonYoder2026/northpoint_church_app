import 'package:go_router/go_router.dart';
import 'package:northpoint_church_app/features/splash/splash_page.dart';
import 'package:northpoint_church_app/features/home/home.dart';
import 'package:northpoint_church_app/features/login/login.dart';
import 'package:northpoint_church_app/features/signup/signup.dart';
import 'package:northpoint_church_app/features/profile/profile.dart';
import 'transitions.dart';
import 'package:northpoint_church_app/features/shell/main_scaffold.dart';
import 'package:northpoint_church_app/features/help/help.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/profile', builder: (_, __) => ProfilePage()),
          ],
        ),
      ],
    ),
  ],
);

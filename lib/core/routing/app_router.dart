import 'package:go_router/go_router.dart';
import 'package:northpoint_church_app/features/events/event_detail.dart';
import 'package:northpoint_church_app/features/events/event_registration.dart';
import 'package:northpoint_church_app/features/events/events.dart';
import 'package:northpoint_church_app/features/prayer/prayer.dart';
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
import 'package:northpoint_church_app/features/watch/watch.dart';
import 'package:northpoint_church_app/features/events/event_model.dart';
import 'package:flutter/material.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/privacy',
      name: 'privacy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/watch',
      name: 'watch',
      builder: (context, state) => const LivestreamPage(),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: '/events',
      name: 'events',
      builder: (context, state) => const EventsPage(),
    ),
    GoRoute(
      path: '/event-details',
      builder: (context, state) {
        final event = state.extra as Event?;
        if (event == null) {
          return Scaffold(
            body: Center(child: Text("No event data provided")),
          );
        }
        return EventDetailPage(event: event);
      },
    ),
    GoRoute(
      path: '/event-registration',
      builder: (context, state) {
        final url = state.extra as String?;
        if (url == null) {
          return const Scaffold(
            body: Center(child: Text('No registration URL provided')),
          );
        }
        return EventRegistrationPage(url: url);
      },
    ),
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    // GoRoute(
    //   path: '/login',
    //   name: 'login',
    //   pageBuilder: (context, state) {
    //     return slideFromRight(child: const LoginPage());
    //   },
    // ),
    // GoRoute(
    //   path: "/signup",
    //   name: "signup",
    //   pageBuilder: (context, state) {
    //     return slideFromRight(child: const SignupPage());
    //   },
    // ),
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
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (_, __) => SettingsPage(),
    ),
    GoRoute(path: '/home', name: 'home', builder: (_, __) => const HomePage()),
    // GoRoute(
    //   path: '/profile',
    //   name: 'profile',
    //   builder: (_, __) => ProfilePage(),
    // ),
    GoRoute(path: '/prayer', name: 'prayer', builder: (_, __) => PrayerPage()),
  ],
);

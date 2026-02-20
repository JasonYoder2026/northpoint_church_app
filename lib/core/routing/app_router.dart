import 'package:go_router/go_router.dart';
import 'package:northpoint_church_app/features/events/event_detail.dart';
import 'package:northpoint_church_app/features/events/event_registration.dart';
import 'package:northpoint_church_app/features/events/events.dart';
import 'package:northpoint_church_app/features/prayer/prayer.dart';
import 'package:northpoint_church_app/features/splash/splash_page.dart';
import 'package:northpoint_church_app/features/home/home.dart';
import 'package:northpoint_church_app/features/settings/settings.dart';
import 'package:northpoint_church_app/features/tithe/tithe.dart';
import 'package:northpoint_church_app/features/privacy/privacy.dart';
import 'package:northpoint_church_app/features/terms/terms.dart';
import 'package:northpoint_church_app/features/volunteer/volunteer.dart';
import 'package:northpoint_church_app/features/watch/watch.dart';
import 'package:northpoint_church_app/features/events/event_model.dart';
import 'package:flutter/material.dart';
import 'transitions.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/privacy',
      name: 'privacy',
      pageBuilder: (context, state) =>
          slideFromRight(child: const PrivacyPolicyPage()),
    ),
    GoRoute(
      path: '/watch',
      name: 'watch',
      pageBuilder: (context, state) =>
          slideFromRight(child: const LivestreamPage()),
    ),
    GoRoute(
      path: '/terms',
      name: 'terms',
      pageBuilder: (context, state) => slideFromRight(child: const TermsPage()),
    ),
    GoRoute(
      path: '/events',
      name: 'events',
      pageBuilder: (context, state) =>
          slideFromRight(child: const EventsPage()),
    ),
    GoRoute(
      path: '/event-details',
      builder: (context, state) {
        final event = state.extra as Event?;
        if (event == null) {
          return Scaffold(body: Center(child: Text("No event data provided")));
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
    GoRoute(
      path: '/volunteer',
      name: 'volunteer',
      pageBuilder: (context, state) =>
          slideFromRight(child: const VolunteerPage()),
    ),
    GoRoute(
      path: '/tithe',
      name: 'tithe',
      pageBuilder: (context, state) => slideFromRight(child: const TithePage()),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(path: '/home', name: 'home', builder: (_, __) => const HomePage()),
    GoRoute(
      path: '/prayer',
      name: 'prayer',
      pageBuilder: (context, state) =>
          slideFromRight(child: const PrayerPage()),
    ),
  ],
);

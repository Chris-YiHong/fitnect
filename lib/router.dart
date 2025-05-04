import 'package:fitnect/core/bottom_menu/bottom_menu.dart';
import 'package:fitnect/core/data/api/analytics_api.dart';
import 'package:fitnect/core/guards/authenticated_guard.dart';
import 'package:fitnect/core/guards/user_info_guard.dart';
import 'package:fitnect/core/widgets/page_not_found.dart';
import 'package:fitnect/modules/authentication/ui/phone_auth_page.dart';
import 'package:fitnect/modules/authentication/ui/recover_password_page.dart';
import 'package:fitnect/modules/authentication/ui/signin_page.dart';
import 'package:fitnect/modules/authentication/ui/signup_page.dart';
import 'package:fitnect/modules/signup/ui/signup_onboarding_page.dart';

import 'package:fitnect/modules/onboarding/ui/onboarding_page.dart';
import 'package:fitnect/modules/subscription/ui/premium_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) => generateRouter());

extension GoRouterRiverpod on Ref {
  GoRouter get goRouter => read(goRouterProvider);
}

final navigatorKey = GlobalKey<NavigatorState>();

GoRouter generateRouter({
  String? initialLocation,
  List<GoRoute>? additionalRoutes,
  List<NavigatorObserver>? observers,
}) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: navigatorKey,
    errorBuilder: (context, state) => const PageNotFound(),
    observers: [
      AnalyticsObserver(analyticsApi: MixpanelAnalyticsApi.instance()),

      ...?observers,
    ],
    routes: [
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => const BottomMenu(),
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        name: 'signupOnboarding',
        path: '/signup/onboarding/:step',
        builder: (context, state) {
          final stepName = state.pathParameters['step']!;
          final step = OnboardingStep.fromRouteName(stepName);
          return SignUpOnboardingPage(step: step);
        },
      ),
      GoRoute(
        name: 'signin',
        path: '/',
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        name: 'signinWithPhone',
        path: '/signinWithPhone',
        builder: (context, state) => const PhoneAuthPage(),
      ),
      GoRoute(
        name: 'premium',
        path: '/premium',
        builder: (context, state) => const PremiumPage(),
      ),

      GoRoute(
        name: 'recover_password',
        path: '/recover_password',
        builder: (context, state) => const RecoverPasswordPage(),
      ),
      GoRoute(
        name: '404',
        path: '/404',
        builder: (context, state) => const PageNotFound(),
      ),
    ],
  );
}

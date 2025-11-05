import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/di_files/di.dart';
import 'package:todo/features/authentication/authentication_page.dart';
import 'package:todo/features/authentication/bloc/auth_bloc.dart';
import 'package:todo/features/home/home_page.dart';
import 'package:todo/features/onboarding/onboarding_page.dart';
import 'package:todo/features/splash/bloc/splash_bloc.dart';
import 'package:todo/features/splash/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      // Splash et Auth routes
      GoRoute(
        path: '/',
        name: SplashPage.routeName,
        builder: (context, state) => BlocProvider(
          create: (BuildContext context) =>
              getIt<SplashBloc>()..add(CheckAppStatusEvent()),
          child: const SplashPage(),
        ),
      ),
      // Onboarding route
      GoRoute(
        path: '/${OnboardingPage.routeName}',
        name: OnboardingPage.routeName,
        builder: (context, state) => OnboardingPage(),
      ),
      // Authentication page
      GoRoute(
        path: '/${AuthenticationPage.routeName}',
        name: AuthenticationPage.routeName,
        builder: (context, state) => BlocProvider(
          create: (BuildContext context) =>
              getIt<AuthBloc>(),
          child: const AuthenticationPage(),
        ),
      ),
      // Home page
      GoRoute(
        path: '/${HomePage.routeName}',
        name: HomePage.routeName,
        builder: (context, state) => HomePage(),
      ),
    ],
  );
}

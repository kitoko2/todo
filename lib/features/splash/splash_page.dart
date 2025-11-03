import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/authentication/authentication_page.dart';
import 'package:todo/features/home/home_page.dart';
import 'package:todo/features/onboarding/onboarding_page.dart';
import 'package:todo/features/splash/bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  static String routeName = "splash";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            context.go('/${HomePage.routeName}');
          } else if (state is SplashUnauthenticated) {
            context.goNamed(OnboardingPage.routeName);
          } else if (state is SplashOnboardingCompleted) {
            context.goNamed(AuthenticationPage.routeName);
          }
        },
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

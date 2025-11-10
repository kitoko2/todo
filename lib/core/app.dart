import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/di_files/di.dart';
import 'package:todo/core/theme/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<GoRouter>();
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: "TODO",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          primary: AppColors.primary500,
          seedColor: AppColors.linkHover,
          secondary: AppColors.primary600,
        ),
      ),
      builder: (context, child) {
        // Pour limiter l'échelle du texte en fonction de l'accessibilité de l'utilisateur
        // On lit les paramètres de MediaQuery actuels
        final mediaQuery = MediaQuery.of(context);
        // Création du nouveau MediaQuery avec les paramètres contrôlés
        return MediaQuery(
          data: mediaQuery.copyWith(
            // Limiter l'échelle du texte
            textScaler: mediaQuery.textScaler.clamp(
              minScaleFactor: 1.0,
              maxScaleFactor: 1.25,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/app.dart';
import 'package:todo/core/di_files/di.dart';
import 'package:todo/features/authentication/bloc/auth_bloc.dart';
import 'package:todo/features/splash/bloc/splash_bloc.dart';
import 'package:todo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize dependencies
  await Di.init();

  // runApp(const MyApp());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

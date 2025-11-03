import 'package:get_it/get_it.dart';
import 'package:todo/data/auth_repository.dart';
import 'package:todo/features/splash/bloc/splash_bloc.dart';

class AuthModule {
  static Future<void> init(GetIt getIt) async {
    // Register AuthRepository
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

    // Bloc
    getIt.registerFactory<SplashBloc>(
      () => SplashBloc(authRepository: getIt<AuthRepository>()),
    );
  }
}

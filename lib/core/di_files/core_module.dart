import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/router.dart';

class CoreModule {
  static Future<void> init(GetIt getIt) async {
    getIt.registerSingleton<GoRouter>(AppRouter.router);
  }
}

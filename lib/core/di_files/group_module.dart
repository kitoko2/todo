import 'package:get_it/get_it.dart';
import 'package:todo/data/group_repository.dart';
import 'package:todo/features/home/bloc/groupes/group_bloc.dart';

class GroupModule {
  static Future<void> init(GetIt getIt) async {
    // Register GroupRepository
    getIt.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl());

    // Bloc
    getIt.registerFactory<GroupBloc>(
      () => GroupBloc(groupRepository: getIt<GroupRepository>()),
    );
  }
}

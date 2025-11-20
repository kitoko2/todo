import 'package:get_it/get_it.dart';
import 'package:todo/data/note_repository.dart';
import 'package:todo/features/home/bloc/notes/note_bloc.dart';

class NoteModule {
  static Future<void> init(GetIt getIt) async {
    // Register AuthRepository
    getIt.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl());

    // Bloc
    getIt.registerFactory<NoteBloc>(
      () => NoteBloc(noteRepository: getIt<NoteRepository>()),
    );
  }
}

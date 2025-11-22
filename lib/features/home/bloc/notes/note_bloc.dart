import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/note_repository.dart';
import 'package:todo/domain/entities/home/notes.dart';
import 'package:todo/utils/constants/note_tags.dart';

// Note- state
class NoteState extends Equatable {
  final String? message;
  final List<Notes>? notes;
  final bool isLoading;
  final List<TagModel> tags;
  final bool? success;

  const NoteState({
    this.message,
    this.notes = const [],
    this.isLoading = false,
    this.tags = const [],
    this.success = false,
  });

  NoteState copyWith({
    List<Notes>? notes,
    String? message,
    bool? isLoading,
    List<TagModel>? tags,
    bool? success,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      message: message,
      tags: tags ?? this.tags,
      success: success ?? this.success,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [notes, message, isLoading, tags, success];
}

// Note- Event

abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNotesEvent extends NoteEvent {
  final String uid;
  GetNotesEvent({required this.uid});
  @override
  List<Object?> get props => [uid];
}

class CreateNoteEvent extends NoteEvent {
  final Notes note;

  CreateNoteEvent({required this.note});
  @override
  List<Object?> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final Notes note;

  UpdateNoteEvent({required this.note});
  @override
  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final String noteId;
  DeleteNoteEvent({required this.noteId});
}

class AddTagEvent extends NoteEvent {
  final TagModel tag;
  AddTagEvent({required this.tag});
}

// Note Bloc
class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({required this.noteRepository}) : super(const NoteState()) {
    on<GetNotesEvent>(_getNotes);
    on<CreateNoteEvent>(_createNote);
    on<UpdateNoteEvent>(_updateNote);
    on<DeleteNoteEvent>(_deleteNote);
    on<AddTagEvent>(_fillTags);
  }

  Stream<List<Notes>> getUserNotesStream() {
    return noteRepository.getNotesStream().map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          return Notes.fromFirestore(doc);
        } catch (e, s) {
          print(s);
          return Notes.fromFirestore(doc);
        }
      }).toList();
    });
  }

  void _fillTags(AddTagEvent event, Emitter<NoteState> emit) {
    final newTags = List<TagModel>.from(
      state.tags,
    ); // copie mutable & inverse pour le bon ordre
    if (newTags.contains(event.tag)) {
      newTags.remove(event.tag);
    } else {
      newTags.insert(0, event.tag);
    }

    emit(state.copyWith(tags: newTags));
  }

  /*************  ✨ Windsurf Command ⭐  *************/
  /// Récupère les notes de l'utilisateur courant.
  ///
  /// Si la récupération est une réussite, emet un état avec les notes récupérées.
  /// Si la récupération échoue, emet un état avec isLoading = false, message = l'erreur de la récupération.
  /// Enfin, emet un état avec isLoading = false, message = null pour remettre l'état à zéro.

  void _getNotes(GetNotesEvent event, Emitter<NoteState> emit) async {
    emit(state.copyWith(isLoading: true, message: "Veuillez patienter ..."));
    try {
      final result = await noteRepository.getCurrentUserNotes();
      emit(state.copyWith(notes: result));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, message: null));
    }
  }

  void _createNote(CreateNoteEvent event, Emitter<NoteState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: "Creation en cours ..."));
      await noteRepository.createNote(event.note);
      emit(state.copyWith(message: "Note créée avec succès.", success: true));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, message: e.toString(), success: false),
      );
    } finally {
      emit(state.copyWith(isLoading: false, message: null));
    }
  }

  void _updateNote(UpdateNoteEvent event, Emitter<NoteState> emit) async {
    try {} catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, message: null));
    }
  }

  void _deleteNote(DeleteNoteEvent event, Emitter<NoteState> emit) async {
    try {} catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, message: null));
    }
  }
}

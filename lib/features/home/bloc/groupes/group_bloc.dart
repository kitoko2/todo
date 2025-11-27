import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/group_repository.dart';
import 'package:todo/domain/entities/home/group.dart';

// Group- state
class GroupState extends Equatable {
  final String? message;
  final bool isLoading;
  final bool? success;

  const GroupState({
    this.message,
    this.isLoading = false,
    this.success = false,
  });

  GroupState copyWith({String? message, bool? isLoading, bool? success}) {
    return GroupState(
      message: message,
      success: success ?? this.success,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [message, isLoading, success];
}

// Group- Event
abstract class GroupEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGroupsEvent extends GroupEvents {
  final String uid;
  GetGroupsEvent({required this.uid});
  @override
  List<Object?> get props => [uid];
}

class CreateGroupEvent extends GroupEvents {
  final GroupModel group;

  CreateGroupEvent({required this.group});
  @override
  List<Object?> get props => [group];
}

class UpdateGroupEvents extends GroupEvents {
  final GroupModel group;
  UpdateGroupEvents({required this.group});
  @override
  @override
  List<Object?> get props => [group];
}

class DeleteGroupEvents extends GroupEvents {
  final String groupId;
  DeleteGroupEvents({required this.groupId});
}

// Groupe Bloc
class GroupBloc extends Bloc<GroupEvents, GroupState> {
  final GroupRepository groupRepository;

  GroupBloc({required this.groupRepository}) : super(const GroupState()) {
    on<CreateGroupEvent>(_createGroup);
    on<UpdateGroupEvents>(_updateGroup);
    on<DeleteGroupEvents>(_deleteGroup);
  }

  Stream<List<GroupModel>> getUserGroups() {
    return groupRepository.getGroupStream().map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          return GroupModel.fromFirestore(doc);
        } catch (e, s) {
          print(s);
          return GroupModel.fromFirestore(doc);
        }
      }).toList();
    });
  }

  void _createGroup(CreateGroupEvent event, Emitter<GroupState> emit) async {
    try {
      await groupRepository.createGroup(event.group);
      emit(state.copyWith(message: "Groupe créé avec succès.", success: true));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, message: e.toString(), success: false),
      );
    } finally {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(isLoading: false, message: null, success: false));
      });
    }
  }

  void _updateGroup(UpdateGroupEvents event, Emitter<GroupState> emit) async {
    try {
      await groupRepository.updateGroup(event.group);
      emit(
        state.copyWith(
          message: "Groupe mise à jour avec succès.",
          success: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    } finally {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(isLoading: false, message: null, success: false));
      });
    }
  }

  void _deleteGroup(DeleteGroupEvents event, Emitter<GroupState> emit) async {
    try {
      await groupRepository.deleteGroup(event.groupId);
      emit(
        state.copyWith(message: "Groupe supprimé avec succès.", success: true),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    } finally {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(isLoading: false, message: null, success: false));
      });
    }
  }
}

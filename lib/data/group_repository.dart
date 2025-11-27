import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/domain/entities/home/group.dart';
import 'package:todo/domain/entities/home/notes.dart';
import 'package:todo/utils/constants/firebase_collection.dart';

abstract class GroupRepository {
  Future<void> createGroup(GroupModel group);
  Future<void> updateGroup(GroupModel group);
  Future<void> deleteGroup(String groupId);
  Stream<QuerySnapshot> getGroupStream();

  //  group note CRUD
  Future<void> addNoteToGroup(String groupId, Notes note);
  Future<void> removeNoteFromGroup(String groupId, Notes note);
  Future<void> updateNoteInGroup(String groupId, Notes note);
}

class GroupRepositoryImpl implements GroupRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GroupRepositoryImpl({FirebaseFirestore? firebaseFirestore})
    : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  String get userId => _auth.currentUser!.uid;
  @override
  Future<void> createGroup(GroupModel group) async {
    try {
      var initialMember = _auth.currentUser!.email!;
      GroupModel groupData = group.copyWith(
        createdBy: userId,
        nameMember: [initialMember],
      );
      await _firebaseFirestore
          .collection(FirebaseCollections.groupsCollection)
          .doc(group.id)
          .set(groupData.toFirestore());
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollections.groupsCollection)
          .doc(groupId)
          .delete();
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getGroupStream() {
    try {
      final email = FirebaseAuth.instance.currentUser!.email;
      final result = FirebaseFirestore.instance
          .collection(FirebaseCollections.groupsCollection)
          .where("nameMember", arrayContains: email)
          .snapshots();
      return result;
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  @override
  Future<void> updateGroup(GroupModel group) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollections.groupsCollection)
          .doc(group.id)
          .update(group.toFirestore());
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  @override
  Future<void> addNoteToGroup(String groupId, Notes note) {
    try {
      return getGroupNoteRef(groupId, note.id).set(note.toFirestore());
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  @override
  Future<void> removeNoteFromGroup(String groupId, Notes note) {
    try {
      return getGroupNoteRef(groupId, note.id!).delete();
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  @override
  Future<void> updateNoteInGroup(String groupId, Notes note) {
    try {
      return getGroupNoteRef(groupId, note.id!).update(note.toFirestore());
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  DocumentReference<Map<String, dynamic>> getGroupNoteRef(
    String groupId,
    String? noteId,
  ) {
    return _firebaseFirestore
        .collection(FirebaseCollections.groupsCollection)
        .doc(groupId)
        .collection(FirebaseCollections.notesCollection)
        .doc(noteId);
  }
}

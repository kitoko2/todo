import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/domain/entities/home/notes.dart';

abstract class NoteRepository {
  Future<List<Notes>> getCurrentUserNotes();
  Future<void> createNote(Notes note);
  Future<void> updateNote(Notes note);
  Future<void> deleteNote(Notes note);
  Stream<QuerySnapshot> getNotesStream();
}

class NoteRepositoryImpl implements NoteRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  NoteRepositoryImpl({FirebaseFirestore? firebaseFirestore})
    : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  String get userId => _auth.currentUser!.uid;

  @override
  Future<List<Notes>> getCurrentUserNotes() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => Notes.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception("Erreur lors de la récupération des notes : $e");
    }
  }

  @override
  Stream<QuerySnapshot> getNotesStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final result = FirebaseFirestore.instance
        .collection('notes')
        .where('uid', isEqualTo: uid)
        // TODO: à revoir
        // .orderBy('createdAt', descending: true)
        .snapshots();
   
    return result;
  }

  @override
  Future<void> createNote(Notes note) async {
    try {
      await _firebaseFirestore
          .collection('notes')
          .doc(note.id)
          .set(note.toFirestore());
    } catch (e) {
      throw Exception("Erreur lors de la création de la note : $e");
    }
  }

  @override
  Future<void> updateNote(Notes note) async {
    try {
      // await _firebaseFirestore
      //     .collection('users')
      //     .doc(userId)
      //     .collection('notes')
      //     .doc(note.id)
      //     .update(note.toMap());
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour de la note : $e");
    }
  }

  @override
  Future<void> deleteNote(Notes note) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(note.id)
          .delete();
    } catch (e) {
      throw Exception("Erreur lors de la suppression de la note : $e");
    }
  }
}

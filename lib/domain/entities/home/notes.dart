import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/// ----------------------
///  MODEL : TODO ITEM
/// ----------------------
class Todo {
  final bool check;
  final String title;

  Todo({required this.check, required this.title});

  // Convert Firestore → Todo
  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(check: data['check'] ?? false, title: data['title'] ?? '');
  }

  // Convert Todo → Map (Firestore)
  Map<String, dynamic> toMap() {
    return {'check': check, 'title': title};
  }
}

/// ----------------------
///  MODEL : NOTES
/// ----------------------
class Notes {
  final String? id;
  final String title;
  final String? description;
  final String uid;
  final DateTime? createdAt;

  /// Sous-liste : éléments Todo
  final List<Todo> todoItems;

  /// Tags de la note
  final List<String> tags;

  Notes({
    this.id,
    required this.title,
    this.description,
    required this.uid,
    this.createdAt,
    this.todoItems = const [],
    this.tags = const [],
  });

  /// ------------------------------
  ///  Firestore → Model (from doc)
  /// ------------------------------
  factory Notes.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Notes(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'],
      uid: data['uid'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),

      /// Convertir la liste de Map en liste de Todo
      todoItems: (data['todoItems'] as List<dynamic>? ?? [])
          .map((e) => Todo.fromMap(e as Map<String, dynamic>))
          .toList(),

      /// Récupération des tags (List<String>)
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  /// ------------------------------
  ///  Model → Firestore (to Map)
  /// ------------------------------
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'uid': uid,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),

      /// Convertir Liste<Todo> → Liste<Map>
      'todoItems': todoItems.map((t) => t.toMap()).toList(),

      /// Tags en liste simple
      'tags': tags,
    };
  }

  Notes copyWith({
    String? id,
    String? title,
    String? description,
    String? uid,
    DateTime? createdAt,
    List<Todo>? todoItems,
    List<String>? tags,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      todoItems: todoItems ?? this.todoItems,
      tags: tags ?? this.tags,
    );
  }

  String get date {
    if (createdAt == null) return '';
    return DateFormat("dd MMM").format(createdAt!).toUpperCase();
  }
}


// Exemple de note 

// Titre: Dépenses
// Description:  Dépenses du mois de janvier
// todoItems :
//  - Savon   
//  - Telephone
//  - Internet
// tags : 
//  - Finance
//  - Travail
//  - Perso

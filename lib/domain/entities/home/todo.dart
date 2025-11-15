import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final bool completed;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? completedAt;
  final DateTime? dueDate;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
    required this.createdBy,
    this.createdAt,
    this.completedAt,
    this.dueDate,
  });

  // Créer un Todo depuis un document Firestore
  factory Todo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'],
      completed: data['completed'] ?? false,
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      completedAt: (data['completedAt'] as Timestamp?)?.toDate(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
    );
  }

  // Convertir en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      'createdBy': createdBy,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
    };
  }

  // Copier avec modifications
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
    String? createdBy,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? dueDate,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  // Méthodes utiles
  bool get isOverdue {
    if (dueDate == null || completed) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  bool get hasDueDate => dueDate != null;

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, completed: $completed, createdBy: $createdBy)';
  }
}

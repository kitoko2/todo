import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/entities/home/notes.dart';

class GroupModel extends Equatable {
  final String? id;
  final String name;
  final List<String>? nameMember;
  final DateTime? createdAt;
  final String? createdBy;
  final Notes? notes;

const GroupModel({
    this.id,
    required this.name,
    this.nameMember,
    this.createdAt,
    this.createdBy,
    this.notes,
  });

  // Créer un Group depuis un document Firestore
  factory GroupModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupModel(
      id: doc.id,
      name: data['name'] ?? '',
      nameMember: List<String>.from(data['nameMember'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      createdBy: data['createdBy'] ?? '',
      notes: data['notes'] != null ? Notes.fromFirestore(data['notes']) : null,
    );
  }

  // Convertir en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'nameMember': nameMember,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'createdBy': createdBy,
      'notes': notes?.toFirestore(),
    };
  }

  String get dateFormated {
    if (createdAt == null) return '';
    return DateFormat("dd MMM").format(createdAt!).toUpperCase();
  }

  // create copyWith
  GroupModel copyWith({
    String? id,
    String? name,
    List<String>? nameMember,
    DateTime? createdAt,
    String? createdBy,
    Notes? notes,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameMember: nameMember ?? this.nameMember,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      notes: notes ?? this.notes,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    nameMember,
    createdAt,
    createdBy,
    notes,
  ];
}

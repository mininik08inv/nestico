import 'package:uuid/uuid.dart';

class Nest {
  String id;
  String name;
  String? description;
  String? createdBy;
  DateTime createdAt;
  bool isActive;

  Nest({
    String? id,
    required this.name,
    this.description,
    this.createdBy,
    required this.createdAt,
    this.isActive = true,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'is_active': isActive ? 1 : 0,
    };
  }

  factory Nest.fromMap(Map<String, dynamic> map) {
    return Nest(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      createdBy: map['created_by'],
      createdAt: DateTime.parse(map['created_at']),
      isActive: map['is_active'] == 1,
    );
  }
}

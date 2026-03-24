import 'package:uuid/uuid.dart';

class Task {
  String id; // UUID
  String title;
  String description;
  int quadrant;
  bool isCompleted;
  String? nestId; // UUID гнезда (может быть null)
  DateTime createdAt;
  String? createdBy; // UUID создателя
  DateTime? dueDate;
  DateTime? updatedAt;
  int orderIndex;

  Task({
    String? id, // если не передан, генерируем новый
    required this.title, // название задачи
    required this.description, //Описание задачи
    required this.quadrant, // К какому квадрату задача относится
    this.isCompleted = false, // Выполнена задача или нет
    this.nestId, // UUID гнезда (может быть null)
    required this.createdAt,// Когда создана задача
    this.createdBy, // UUID создателя
    this.dueDate, // Дата дедлайна
    this.updatedAt, // Когда задача была обновлена
    this.orderIndex = 0, // Порядок задачи в гнезде
  }) : id = id ?? const Uuid().v4(); // генерация UUID если не передан

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'quadrant': quadrant,
      'is_completed': isCompleted ? 1 : 0,
      'nest_id': nestId,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'due_date': dueDate?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'order_index': orderIndex,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      quadrant: map['quadrant'],
      isCompleted: map['is_completed'] == 1,
      nestId: map['nest_id'],
      createdAt: DateTime.parse(map['created_at']),
      createdBy: map['created_by'],
      dueDate: map['due_date'] != null ? DateTime.parse(map['due_date']) : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
      orderIndex: map['order_index'] ?? 0,
    );
  }
}

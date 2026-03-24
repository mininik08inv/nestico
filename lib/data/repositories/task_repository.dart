// lib/data/repositories/task_repository.dart
import '../../models/task.dart';
import '../database/database_service.dart';

class TaskRepository {
  final DatabaseService _db = DatabaseService();
  final String table = 'tasks';

  // Create
  Future<int> createTask(Task task) async {
    return await _db.insert(table, task.toMap());
  }

  // Read all
  Future<List<Task>> getAllTasks() async {
    final results = await _db.query(table);
    return results.map((map) => Task.fromMap(map)).toList();
  }

  // Read by nest
  Future<List<Task>> getTasksByNest(int nestId) async {
    final results = await _db.query(
      table,
      where: 'nest_id = ?',
      whereArgs: [nestId],
    );
    return results.map((map) => Task.fromMap(map)).toList();
  }

  // Read by quadrant
  Future<List<Task>> getTasksByQuadrant(int quadrant) async {
    final results = await _db.query(
      table,
      where: 'quadrant = ?',
      whereArgs: [quadrant],
    );
    return results.map((map) => Task.fromMap(map)).toList();
  }

  // Update
  Future<int> updateTask(Task task) async {
    return await _db.update(
      table,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Toggle completed
  Future<int> toggleTaskStatus(int taskId, bool isCompleted) async {
    return await _db.update(
      table,
      {'is_completed': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  // Delete
  Future<int> deleteTask(int id) async {
    return await _db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // Delete all tasks in nest
  Future<int> deleteTasksByNest(int nestId) async {
    return await _db.delete(table, where: 'nest_id = ?', whereArgs: [nestId]);
  }
}

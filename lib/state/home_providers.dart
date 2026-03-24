import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:nestico/data/repositories/task_repository.dart';
import 'package:nestico/models/task.dart';

// Выбранный пункт нижнего меню: 0 - матрица, 1 - добавление.
final selectedHomeTabProvider = StateProvider((ref) => 0);

// Список задач, загружаемый из SQLite.
final tasksProvider = FutureProvider<List<Task>>((ref) async {

  return TaskRepository().getAllTasks();
});


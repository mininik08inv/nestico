import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nestico/models/task.dart';
import 'package:nestico/screens/add_task/add_task_screen.dart';
import 'package:nestico/screens/home/home_bottom_menu.dart';
import 'package:nestico/screens/home/my_drawer.dart';
import 'package:nestico/screens/home/task_quadrant.dart';
import 'package:nestico/state/home_providers.dart';
import 'package:nestico/theme/theme_extensions.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedHomeTabProvider);
    final tasksAsync = ref.watch(tasksProvider);

    return tasksAsync.when(
      loading: () => Scaffold(
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('Ошибка загрузки задач: $error')),
      ),
      data: (tasks) {
        // Как и раньше: 0 - матрица, 1 - добавление.
        // При выборе 3-го пункта нижнего меню будет IndexError —
        // это соответствует текущей логике (чат пока не реализован).
        final screens = [
          _MainMatrixScreen(tasks: tasks),
          const AddTaskScreen(),
        ];

        return Scaffold(
          endDrawer: myEndDrawer(context),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).customBrown,
            scrolledUnderElevation: 0,
            title: Text(
              title,
              style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu_open),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(color: Theme.of(context).customBrown),
            child: screens[selectedIndex],
          ),
          bottomNavigationBar: homeBottomMenu(
            context: context,
            selectedIndex: selectedIndex,
            onTap: (index) =>
                ref.read(selectedHomeTabProvider.notifier).state = index,
          ),
        );
      },
    );
  }
}

// Отдельный виджет для матрицы задач
class _MainMatrixScreen extends StatelessWidget {
  const _MainMatrixScreen({required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              // Первая строка
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TaskQuadrant(
                        title: 'Важно и срочно',
                        tasks: tasks.where((task) => task.quadrant == 1).toList(),
                        color: Colors.red,
                        tooltip: 'Важно и срочно\nДевиз: "Кризис и дедлайны"...',
                      ),
                    ),
                    Expanded(
                      child: TaskQuadrant(
                        title: 'Важно, но не срочно',
                        tasks: tasks.where((task) => task.quadrant == 2).toList(),
                        color: Colors.greenAccent,
                        tooltip:
                            'Важно, но не срочно\nДевиз: "Стратегия и качество жизни"...',
                      ),
                    ),
                  ],
                ),
              ),
              // Вторая строка
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TaskQuadrant(
                        title: 'Не важно, но срочно',
                        tasks: tasks.where((task) => task.quadrant == 3).toList(),
                        color: Colors.yellow,
                        tooltip:
                            'Не важно, но срочно\nДевиз: "Чужие проблемы и помехи"...',
                      ),
                    ),
                    Expanded(
                      child: TaskQuadrant(
                        title: 'Не важно и не срочно',
                        tasks: tasks.where((task) => task.quadrant == 4).toList(),
                        color: Colors.blueGrey.shade200,
                        tooltip: 'Не важно и не срочно\n...',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


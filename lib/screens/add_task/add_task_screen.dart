import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nestico/data/repositories/task_repository.dart';
import 'package:nestico/models/task.dart';
import 'package:nestico/screens/add_task/add_task_controllers.dart';
import 'package:nestico/state/home_providers.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final Function()? onTaskAdded;

  const AddTaskScreen({super.key, this.onTaskAdded});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _controllers = TaskControllers();
  final _repository = TaskRepository();
  final _formKey = GlobalKey<FormState>();

  // Значения для квадрантов
  final Map<int, String> quadrants = {
    1: 'Важно и срочно',
    2: 'Важно, но не срочно',
    3: 'Не важно, но срочно',
    4: 'Не важно и не срочно',
  };

  int? _selectedQuadrant; // Для выбора квадранта через dropdown

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        nestId: '1',
        title: _controllers.titleController.text,
        description: _controllers.descriptionController.text,
        quadrant: _selectedQuadrant ?? 4, // Если не выбран, ставим по умолчанию
        dueDate: _controllers.selectedDate,
        createdBy: 'Creator',
        createdAt: DateTime.now(),
      );

      await _repository.createTask(task);

      // Теперь ref доступен напрямую через context.read или ref.read
      // ref.read(selectedHomeTabProvider.notifier).state = 0;
      
      // Возвращаем результат и обновляем главный экран
      if (mounted) {
        // Вариант 1: Используем ref (доступен из ConsumerState)
        ref.read(selectedHomeTabProvider.notifier).state = 0;
        
        // Вариант 2: Используем context.read (альтернатива)
        // context.read(selectedHomeTabProvider.notifier).state = 0;
        
       // Navigator.pop(context, true); // true означает, что задача добавлена
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить задачу'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save), 
            onPressed: _saveTask  // ✅ Теперь работает - нет параметров
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _controllers.titleController,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Введите название' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controllers.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // Выбор квадранта
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Квадрант',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedQuadrant,
                  items: quadrants.entries.map((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedQuadrant = value;
                      _controllers.quadrantController.text = value.toString();
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Выберите квадрант' : null,
                ),
                const SizedBox(height: 16),

                // Выбор даты
                ListTile(
                  title: Text(
                    _controllers.selectedDate == null
                        ? 'Выберите дату'
                        : 'Дедлайн: ${_controllers.selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _controllers.selectedDate = date;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class TaskControllers {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController quadrantController = TextEditingController();

  // Для чекбоксов/переключателей
  bool isCompleted = false;

  // Для выбора даты
  DateTime? selectedDate;

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    quadrantController.dispose();
  }

  void clear() {
    titleController.clear();
    descriptionController.clear();
    deadlineController.clear();
    quadrantController.clear();
    isCompleted = false;
    selectedDate = null;
  }
}

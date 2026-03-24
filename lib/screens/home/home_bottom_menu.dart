import 'package:flutter/material.dart';
import 'package:nestico/theme/theme_extensions.dart';

Widget homeBottomMenu({
  required BuildContext context,
  required int selectedIndex,
  required Function(int) onTap,
}) {
  return BottomNavigationBar(
    backgroundColor: Theme.of(context).customBrown,
    elevation: 0,
    currentIndex: selectedIndex,
    onTap: onTap,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard, size: 30), // Изменил иконку для матрицы
        label: 'Матрица',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_box, size: 30),
        label: 'Добавить',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.chat, size: 30), label: 'Чат'),
    ],
  );
}

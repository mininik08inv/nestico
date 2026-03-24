import 'package:flutter/material.dart';
import 'package:nestico/screens/about_app/about_app.dart';
import 'package:nestico/theme/theme_extensions.dart';

Widget myEndDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Theme.of(context).customMyDrawerColor,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).customMyDrawerHeaderColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Icon(Icons.nest_cam_wired_stand, size: 40, color: Colors.white),
                const Image(
                  image: AssetImage('assets/images/nest.png'),
                  width: 70,
                  height: 70,
                ),
                SizedBox(height: 4),
                Text(
                  'Nestico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Мои задачи в полном порядке',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.settings_suggest_outlined,
            color: Color.fromARGB(255, 144, 77, 48),
          ),
          title: Text('Настройка гнезда'),
          subtitle: Text(
            'Изменение названия, состава, цвет квадратов',
            style: TextStyle(fontSize: 12),
          ),
          onTap: () {
            Navigator.pop(context); // закрыть drawer
            // TODO: открыть экран выбора гнезда или bottom sheet
          },
        ),
        ListTile(
          leading: Icon(
            Icons.swap_horiz,
            color: Color.fromARGB(255, 144, 77, 48),
          ),
          title: Text('Сменить гнездо'),
          subtitle: Text(
            'Выберите гнездо из тех в которых вы состоите',
            style: TextStyle(fontSize: 12),
          ),
          onTap: () {
            Navigator.pop(context); // закрыть drawer
            // TODO: открыть экран выбора гнезда или bottom sheet
          },
        ),
        ListTile(
          leading: Icon(
            Icons.add_circle_outline,
            color: Color.fromARGB(255, 144, 77, 48),
          ),
          title: Text('Создать гнездо'),
          onTap: () {
            Navigator.pop(context);
            // TODO: создать новое гнездо (личное или общее)
          },
        ),
        Divider(color: Theme.of(context).customMyDrawerColor),
        ListTile(
          leading: Icon(Icons.person, color: Color.fromARGB(255, 144, 77, 48)),
          title: Text('Мои данные'),
          subtitle: Text('ФИО, гнёзда, ...', style: TextStyle(fontSize: 12)),
          onTap: () {
            Navigator.pop(context);
            // TODO: показать мои данные
          },
        ),
        Divider(color: Theme.of(context).customMyDrawerColor),
        ListTile(
          leading: Icon(Icons.settings_outlined, color: Colors.grey),
          title: Text('Настройки'),
          onTap: () {
            Navigator.pop(context);
            // TODO: экран настроек
          },
        ),
        ListTile(
          leading: Icon(Icons.info_outline, color: Colors.grey),
          title: Text('О приложении'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutAppPage()),
            );
          },
        ),
      ],
    ),
  );
}

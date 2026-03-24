import 'package:flutter/material.dart';
import 'package:nestico/theme/theme_extensions.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О приложении'),
        backgroundColor: Theme.of(context).customBrown,
      ),
      body: Container(
        color: Theme.of(context).customBrown,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Nestico', style: TextStyle(fontSize: 30)),
                    ),
                    Text(
                      ' — приложение для планирования задач по матрице Эйзенхауэра. Задачи хранятся в «гнёздах»: личное, семья, друзья, работа. В каждом гнезде — своя матрица. Можно создать общее гнездо и пригласить других — задачи будут видны всем участникам гнезда.',
                      style: TextStyle(fontSize: 17),
                    ),
                    Divider(),
                    Text(
                      'Матрица Эйзенхауэра — это метод тайм-менеджмента, который помогает расставить приоритеты между задачами в зависимости от их срочности и важности. Название отсылает к цитате, которую приписывают американскому президенту Дуайту Эйзенхауэру: «У меня есть два типа проблем: срочные и важные. Срочные не важны, а важные никогда не бывают срочными».',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Divider(),
                  Center(child: Text('Разработчик: Афанасьев Н')),
                  Center(child: Text('Связаться: mininik08@mail.ru')),
                  Center(child: Text('Telegram: @mininik08')),
                  Center(child: Text('GitHub: github.com/mininik08inv')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

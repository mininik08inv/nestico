import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:nestico/models/task.dart';
import 'package:nestico/screens/home/my_drawer.dart';

class QuadrantDetailPage extends StatefulWidget {
  const QuadrantDetailPage({
    super.key,
    required this.title,
    required this.color,
    required this.tasks,
  });

  final String title;
  final List<Task> tasks;
  final Color color;

  @override
  State<QuadrantDetailPage> createState() => _QuadrantDetailPageState();
}

class _QuadrantDetailPageState extends State<QuadrantDetailPage> {
  @override
  Widget build(BuildContext context) {
    //Этот метод запускается повторно каждый раз, когда вызывается setState,
    //Платформа Flutter оптимизирована для повторного запуска методов сборки
    //быстро, так что вы можете просто перестроить все, что требует обновления, а не
    //чем менять экземпляры виджетов по отдельности.

    return Scaffold(
      endDrawer: myEndDrawer(context),
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Theme.of(context).customBrown,,
        backgroundColor: widget.color,
        scrolledUnderElevation: 0,
        title: LayoutBuilder(
          builder: (context, constraints) {
            // Измеряем текст
            final textSpan = TextSpan(
              text: widget.title,
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            );
            final textPainter = TextPainter(
              text: textSpan,
              maxLines: 1,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout();

            final textWidth = textPainter.width;
            final maxAllowedWidth = constraints.maxWidth * 0.85;

            // Если текст короткий - просто текст без Marquee
            if (textWidth < maxAllowedWidth) {
              return Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              );
            }

            // Если длинный - Marquee с максимальной шириной
            return SizedBox(
              height: 30,
              width: maxAllowedWidth,
              child: Marquee(
                text: widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 20.0,
                velocity: 40.0,
                pauseAfterRound: const Duration(seconds: 5),
                startPadding: 10.0,
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
            );
          },
        ),

        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_open),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/nest.png'))),
        decoration: BoxDecoration(color: widget.color),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  // const SizedBox(height: 8),
                  Expanded(
                    child: widget.tasks.isEmpty
                        ? Center(
                            child: Text(
                              'Нет задач',
                              style: TextStyle(fontSize: 24),
                            ),
                          )
                        : ListView.builder(
                            // padding: EdgeInsets.zero,
                            itemCount: widget.tasks.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                // переход к экрану задачи, например:
                                // Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: ...)));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 8,
                                ),
                                child: Text(
                                  widget.tasks[index].title,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: null,
                                  textDirection: null,
                                  overflow: null,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            // homeBottomMenu(context),
          ],
        ),
      ),
    );
  }
}

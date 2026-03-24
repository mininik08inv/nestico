import 'package:flutter/material.dart';
import 'package:nestico/models/task.dart';
import 'package:nestico/screens/task_quadrant_detail/quadrant_detail.dart';

class TaskQuadrant extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final Color color;
  final String? tooltip;

  const TaskQuadrant({
    super.key,
    required this.title,
    required this.tasks,
    required this.color,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.5),
        // border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: const Color.fromARGB(221, 50, 49, 49),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (tooltip != null)
                    Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration: Duration(seconds: 7),
                      message: tooltip,
                      child: Icon(Icons.info_outline, size: 18),
                    ),
                ],
              ),
              // const SizedBox(height: 8),
              Expanded(
                child: tasks.isEmpty
                    ? Center(
                        child: Text(
                          'Нет задач',
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                    : ListView.builder(
                        // padding: EdgeInsets.zero,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            // переход к экрану задачи, например:
                            // Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: ...)));
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: tasks[index].isCompleted,
                                onChanged: (val) {tasks[index].isCompleted = !tasks[index].isCompleted;},
                                visualDensity: VisualDensity.compact,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 3,
                                  ),
                                  child: Text(
                                    tasks[index].title,
                                    style: TextStyle(fontSize: 14),
                                    textAlign: null,
                                    textDirection: null,
                                    overflow: null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 'fab_$title',
              backgroundColor: Colors.indigoAccent,
              mini: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuadrantDetailPage(
                      title: title,
                      color: color,
                      tasks: tasks,
                    ),
                  ),
                );
              },
              child: Icon(Icons.ads_click, size: 32, color: Colors.cyan),
            ),
          ),
        ],
      ),
    );
  }
}

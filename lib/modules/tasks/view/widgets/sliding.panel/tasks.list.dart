import 'package:bots/modules/tasks/view/widgets/sliding.panel/tasks.panel.task.dart';
import 'package:bots/stores/tasks.store.dart';
import 'package:flutter/material.dart';

class TasksList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_,___)=> const Divider(),
            padding: const EdgeInsets.all(20.0),
            itemCount: TasksStore.to.tasks.length,
            itemBuilder: (_, index) {
              final task = TasksStore.to.tasks.reversed.toList()[index];
              return TasksPanelTask(task: task);
            },
          ),
        )
      ],
    );
  }
}

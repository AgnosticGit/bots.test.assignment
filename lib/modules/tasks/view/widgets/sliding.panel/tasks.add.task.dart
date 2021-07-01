import 'package:bots/modules/tasks/controllers/tasks.controller.dart';
import 'package:bots/stores/tasks.store.dart';
import 'package:bots/utils/constants/string.constants.dart';
import 'package:bots/widgets/input.dart';
import 'package:flutter/material.dart';

class TasksAddTask extends StatelessWidget {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            StringConstant.newTask,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Input(
            controller: TasksStore.to.newTaskTextController,
            hintText: StringConstant.taskText,
            onChanged: (val) => TasksController().onInputNewTask(val),
          ),
        ],
      ),
    );
  }
}

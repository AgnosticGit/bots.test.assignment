import 'package:bots/models/task.model.dart';
import 'package:bots/services/api.requests.service.dart';
import 'package:bots/stores/tasks.store.dart';
import 'package:bots/utils/constants/color.constant.dart';
import 'package:bots/utils/constants/string.constants.dart';
import 'package:bots/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksController {
  void onReady() {
    ApiRequestsService.getTaskList();
  }

  void onPressAddTask() {
    TasksStore.to.setPageControllerPage(1);
  }

  void onInputNewTask(String title) {
    TasksStore.to.setNewTaskTitle(title);
  }

  void onClosePanel() {
    TasksStore.to.setPageControllerDefault();
    TasksStore.to.setNewTaskDefault();
  }

  void onPressBackSlidingPanel() {
    TasksStore.to.setPageControllerPage(0);
  }

  void onPressSaveTask() {
    final newTask = TasksStore.to.newTask;

    if (newTask.title.isNotEmpty) {
      ApiRequestsService.addTask(newTask);
      TasksStore.to.setNewTaskDefault();
      TasksStore.to.setNewTaskTextControllerEmptyText();
    } else {
      Get.snackbar(
        StringConstant.addingTaskError,
        StringConstant.taskTextCannotBeEmpty,
        colorText: Colors.white,
        messageText: const Text(
          StringConstant.taskTextCannotBeEmpty,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: ColorConstant.mainAppColor,
      );
    }
  }

  void onPressCheckbox(bool? value, TaskModel task) {
    if (value!) {
      TasksStore.to.setTaskToSelectedTasks(task);
    } else {
      TasksStore.to.removeTaskFromSelectedTasks(task);
    }
  }

  void onSelectSlidingMenuItem(SlidingPanelMenu item) {
    final selectedTasks = TasksStore.to.selectedTasks;

    if (item == SlidingPanelMenu.completed) {
      ApiRequestsService.changeTasksCompletedStatus(selectedTasks, 1);
    }
    if (item == SlidingPanelMenu.notCompleted) {
      ApiRequestsService.changeTasksCompletedStatus(selectedTasks, 0);
    }
    if (item == SlidingPanelMenu.remove) {
      ApiRequestsService.deleteTask(selectedTasks);
    }
  }
}

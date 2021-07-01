import 'package:bots/models/task.model.dart';
import 'package:bots/stores/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TasksStore extends Store {
  static TasksStore get to => Get.put(TasksStore());

  PageController pageController = PageController();
  final newTaskTextController = TextEditingController();

  int currentPage = 0;

  List<TaskModel> tasks = [];
  TaskModel newTask = TaskModel();

  List<TaskModel> selectedTasks = [];
  DateRangePickerSelectionChangedArgs? selectedDates =
      DateRangePickerSelectionChangedArgs(
    PickerDateRange(DateTime(2021), DateTime.now()),
  );

  void setTasks(List<TaskModel> newTasks) {
    tasks = newTasks;
    update();
  }

  void addTask(TaskModel task) {
    tasks.add(task);
    update();
  }

  void rewriteTasksByNewTasks(List<TaskModel> newTasks) {
    newTasks.forEach((newTask) {
      final findedTask = tasks.firstWhere((task) => task.id == newTask.id);
      findedTask.completed = newTask.completed;
    });
    update();
  }

  void insertTask(TaskModel task) {
    tasks.insert(0, task);
    update();
  }

  void setSelectedDate(DateRangePickerSelectionChangedArgs dateTime) {
    selectedDates = dateTime;
    update();
  }

  void setNewTaskId(int id) {
    newTask.id = id;
    update();
  }

  void setSelectedDateDefault() {
    selectedDates = null;
    update();
  }

  void setNewTaskTextControllerEmptyText() {
    newTaskTextController.clear();
    update();
  }

  void setNewTaskToTasks() {
    tasks.insert(0, newTask);
    update();
  }

  void setTaskToSelectedTasks(TaskModel task) {
    selectedTasks.add(task);
    update();
  }

  void setSelectedTasksCompleted(int value) {
    selectedTasks.forEach((selTask) {
      tasks.firstWhere((task) => task.id == selTask.id).completed = value;
    });
    setSelectedTasksDefault();
    update();
  }

  void removeTaskFromSelectedTasks(TaskModel task) {
    selectedTasks.removeWhere((element) => element.id == task.id);
    update();
  }

  void removeFromTasksSelectedTasks() {
    selectedTasks.forEach((selTask) {
      final index = tasks.indexWhere((task) => task.id == selTask.id);
      tasks.removeAt(index);
    });

    setSelectedTasksDefault();
    update();
  }

  void setSelectedTasksDefault() {
    selectedTasks = [];
    update();
  }

  void setNewTaskTime(DateTime createdAt) {
    newTask.createdAt = createdAt;
    update();
  }

  void setNewTask(TaskModel task) {
    newTask = task;
    update();
  }

  void setPageControllerPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
    setCurrentPage(page);
    update();
  }

  void setPageControllerDefault() {
    pageController.jumpToPage(0);
    update();
  }

  void setNewTaskTitle(String newTitle) {
    newTask.title = newTitle;
    update();
  }

  void setNewTaskDefault() {
    newTask = TaskModel();
    update();
  }

  void setCurrentPage(int page) {
    currentPage = page;
    update();
  }

  int getTasksLastIndex() {
    int lastIndex = 0;
    tasks.forEach((task) {
      if (lastIndex < task.id!.toInt()) {
        lastIndex = task.id!.toInt();
      }
    });
    return lastIndex;
  }
}

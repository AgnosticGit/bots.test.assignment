import 'package:bots/models/task.model.dart';

class MathService {
  static int countTasks(List<TaskModel> list, int completed) {
    return list.where((task) {
      if (completed == 1) return task.completed == 1;
      return task.completed == 0;
    }).length;
  }

  static double percentOf(int count, int unit) {
    return unit / count * 100;
  }
}

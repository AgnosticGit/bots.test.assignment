import 'package:bots/services/math.service.dart';
import 'package:bots/stores/tasks.store.dart';
import 'package:bots/utils/constants/color.constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TasksPieChart extends StatelessWidget {
  Widget build(BuildContext context) {
    return PieChart(_buildPieChartData());
  }

  PieChartData _buildPieChartData() {
    final tasks = TasksStore.to.tasks;
    final completedTasks = MathService.countTasks(tasks, 1);
    final notCompletedTasks = MathService.countTasks(tasks, 0);

    final completedTitle = MathService.percentOf(
      tasks.length,
      completedTasks,
    ).toStringAsFixed(2);
    final notCompletedTitle = MathService.percentOf(
      tasks.length,
      notCompletedTasks,
    ).toStringAsFixed(2);

    return _getPieChartDataByTasks(
      completedTasks,
      notCompletedTasks,
      completedTitle,
      notCompletedTitle,
    );
  }

  PieChartData _getPieChartDataByTasks(
    int completedTasks,
    int notCompletedTasks,
    String completedTitle,
    String notCompletedTitle,
  ) {
    final sections = <PieChartSectionData>[
      PieChartSectionData(
        title: "$completedTitle% ($completedTasks)",
        radius: 120.0,
        color: ColorConstant.completedTaskColor,
        value: completedTasks.toDouble(),
      ),
      PieChartSectionData(
        title: "$notCompletedTitle% ($notCompletedTasks)",
        radius: 120.0,
        color: ColorConstant.notCompletedTaskColor,
        value: notCompletedTasks.toDouble(),
      ),
    ];

    return PieChartData(sections: sections, centerSpaceRadius: 0);
  }
}

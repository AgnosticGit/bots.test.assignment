import 'package:bots/models/task.model.dart';
import 'package:bots/stores/tasks.store.dart';
import 'package:bots/utils/constants/color.constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class DaysBarChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DaysBarChartState();
}

class _DaysBarChartState extends State<DaysBarChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: ColorConstant.mainAppDarkColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (_a, _b, _c, _d) => null,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              margin: 20,
              getTitles: (double value) {
                switch (value.toInt()) {
                  case 1:
                    return 'Mn';
                  case 2:
                    return 'Te';
                  case 3:
                    return 'Wd';
                  case 4:
                    return 'Tu';
                  case 5:
                    return 'Fr';
                  case 6:
                    return 'St';
                  case 7:
                    return 'Sn';
                  default:
                    return '';
                }
              },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              margin: 32,
              reservedSize: 14,
              getTitles: (value) {
                if(value % 2 == 0) return value.toStringAsFixed(0);
                return '';
              },
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: _getBarGroups(),
        ),
      ),
    );
  }

  List<BarChartGroupData>? _getBarGroups() {
    final selectedDates = TasksStore.to.selectedDates;

    if (selectedDates == null ||
        selectedDates.value.startDate == null ||
        selectedDates.value.endDate == null) {
      return [];
    }

    final period = [
      selectedDates.value.startDate,
      selectedDates.value.endDate,
    ];
    final tasks = TasksStore.to.tasks;
    final filteredTasks = <TaskModel>[];

    tasks.forEach((task) {
      final taskTimestamp = task.createdAt!.millisecondsSinceEpoch;
      final minPeriodTimestamp = period[0].millisecondsSinceEpoch;
      final maxPeriodTimestamp = period[1].millisecondsSinceEpoch;
    
      if (taskTimestamp >= minPeriodTimestamp &&
          taskTimestamp <= maxPeriodTimestamp) {
        filteredTasks.add(task);
      }
    });

    final Map<int, List<TaskModel>> filteredByDaysTasks = {};

    filteredTasks.forEach((task) {
      if (filteredByDaysTasks[task.createdAt!.weekday] == null) {
        filteredByDaysTasks[task.createdAt!.weekday] = <TaskModel>[];
      }
      if (task.completed == 1) {
        filteredByDaysTasks[task.createdAt!.weekday]?.add(task);
      }
    });

    final dataItems = <BarChartGroupData>[];

    for (final weekday in filteredByDaysTasks.entries) {
      final completedTasks = filteredByDaysTasks[weekday.key]!.length;
      final item = makeGroupData(weekday.key, completedTasks.toDouble());
      dataItems.add(item);
    }

    return dataItems;
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [leftBarColor],
          width: 15,
        ),
      ],
    );
  }
}

import 'package:bots/stores/tasks.store.dart';
import 'package:bots/utils/constants/color.constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksLineChart extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontal = Get.width > Get.height;

    return Container(
      height: horizontal ? Get.height * 0.5 : Get.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
        color: ColorConstant.mainAppDarkColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18.0,
          left: 12.0,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(mainData()),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) {
            return const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            );
          },
          getTitles: (value) {
            if (value == 1) return 'Jan';
            if (value == 3) return 'Mar';
            if (value == 6) return 'Jun';
            if (value == 9) return 'Sep';
            if (value == 12) return 'Dec';
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value % 2 == 0) return value.toStringAsFixed(0);
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      lineBarsData: [
        LineChartBarData(
          spots: _getChartData(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _getChartData() {
    final List<FlSpot> list = [];
    final List<FlSpot> list2 = [];
    final tasks = TasksStore.to.tasks;

    if (tasks.isEmpty) return [FlSpot(0, 0)];

    tasks.forEach((task) {
      if (task.completed == 0) {
        list.add(FlSpot(
          task.createdAt!.month.toDouble(),
          task.completed == 0 ? 1.0 : 0.0,
        ));
      }
    });

    for (int i = 1; i <= DateTime.now().month; i++) {
      int count = 0;
      list.forEach((element) {
        if (element.x == i) {
          count++;
        }
      });
      if (count != 0) {
        list2.add(FlSpot(i.toDouble(), count.toDouble()));
      }
    }
    return list2;
  }
}

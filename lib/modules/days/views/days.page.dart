import 'package:bots/modules/days/views/widgets/days.bar.chart.dart';
import 'package:bots/modules/days/views/widgets/days.range.picker.dart';
import 'package:bots/stores/tasks.store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaysPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TasksStore>(
        builder: (_) {
          final horizontal = Get.width > Get.height;

          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 56.0,
              ),
              child: Column(
                children: [
                  DaysRangePicker(),
                  const SizedBox(height: 30.0),
                  Container(
                    height: horizontal ? Get.height * 0.7 : Get.height * 0.4,
                    constraints: BoxConstraints(maxHeight: Get.height * 0.7),
                    child: DaysBarChart(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

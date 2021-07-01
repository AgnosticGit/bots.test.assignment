import 'package:bots/modules/days/controllers/days.controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DaysRangePicker extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: DaysController().onSelectDate,
            toggleDaySelection: true,
            initialSelectedRange: PickerDateRange(
              DateTime(2021),
              DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }

  // DateTime? _getMinDate() {
  //   final selectedDates = TasksStore.to.selectedDates;
  //   if (selectedDates == null || selectedDates.value.endDate != null) {
  //     return null;
  //   }

  //   const millisecondsInDay = 86400000;
  //   final minDateMS = selectedDates.value.startDate.millisecondsSinceEpoch -
  //       millisecondsInDay * 6;
  //   return DateTime.fromMillisecondsSinceEpoch(minDateMS);
  // }

  // DateTime? _getMaxDate() {
  //   final selectedDates = TasksStore.to.selectedDates;
  //   if (selectedDates == null || selectedDates.value.endDate != null) {
  //     return null;
  //   }

  //   const millisecondsInDay = 86400000;
  //   final minDateMS = selectedDates.value.startDate.millisecondsSinceEpoch +
  //       millisecondsInDay * 6;
  //   return DateTime.fromMillisecondsSinceEpoch(minDateMS);
  // }
}

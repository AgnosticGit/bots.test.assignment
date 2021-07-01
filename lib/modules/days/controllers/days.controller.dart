import 'package:bots/stores/tasks.store.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DaysController {
  void onSelectDate(DateRangePickerSelectionChangedArgs date) {
    TasksStore.to.setSelectedDate(date);
  }

  void onPressClearSelectedDateRange() {
    TasksStore.to.setSelectedDateDefault();
  }
}

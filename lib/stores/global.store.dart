import 'package:bots/stores/store.dart';
import 'package:get/get.dart';

class GlobalStore extends Store {
  static GlobalStore get to => Get.put(GlobalStore());

  bool _internetDisconnected = false;
  bool get internetDisconnected => _internetDisconnected;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  void setInternetDisconnected(bool value){
    _internetDisconnected = value;
    update();
  }
}

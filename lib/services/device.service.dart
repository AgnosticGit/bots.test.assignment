import 'package:bots/utils/enums.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceService {
  static DeviceType getDeviceType() {
    final shortestSide = MediaQuery.of(Get.context!).size.shortestSide;

    DeviceType type;
    if (kIsWeb) {
      final screenWidth = Get.width;
      if (screenWidth <= 768) {
        type = DeviceType.mobile;
      } else if (screenWidth <= 1366) {
        type = DeviceType.tablet;
      } else {
        type = DeviceType.desktop;
      }
    } else {
      if (shortestSide <= 600) {
        type = DeviceType.mobile;
      } else if (shortestSide <= 1024) {
        type = DeviceType.tablet;
      } else {
        type = DeviceType.desktop;
      }
    }
    
    return type;
  }
}

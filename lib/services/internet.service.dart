import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class InternetService {
  Future<ConnectivityResult> connectType() async {
    return Connectivity().checkConnectivity();
  }

  Future<bool> isConnected() async {
    final connectionType = await connectType();
    if (connectionType == ConnectivityResult.none) {
      return false;
    }
    return lookUpInternet();
  }

  Future<bool> lookUpInternet() async {
    if (kIsWeb) return true;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}

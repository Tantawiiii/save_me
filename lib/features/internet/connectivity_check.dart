import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

StreamController<bool> internetStatusController = StreamController<bool>.broadcast();

Future<bool> checkInternetStatus() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  bool isOnline = connectivityResult != ConnectivityResult.none;
  internetStatusController.add(isOnline);
  return isOnline;
}


class ConnectionChecker {
  static Future<void> checkConnection(Function(bool) onConnectionChanged) async {
    ConnectivityResult connectivityResult = await _checkNetworkConnection();
    bool isOnline;

    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      isOnline = true;
    } else {
      isOnline = false;
    }

    onConnectionChanged(isOnline);
  }

  static Future<ConnectivityResult> _checkNetworkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }
}
Future<bool> refreshInternetStatus() async {
  bool online = await checkInternetStatus();
  return online;
}
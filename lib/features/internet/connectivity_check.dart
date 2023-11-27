import 'dart:async';

import 'package:connectivity/connectivity.dart';

StreamController<bool> internetStatusController = StreamController<bool>.broadcast();

Future<bool> checkInternetStatus() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  bool isOnline = connectivityResult != ConnectivityResult.none;
  internetStatusController.add(isOnline);
  return isOnline;
}

Future<bool> refreshInternetStatus() async {
  bool online = await checkInternetStatus();
  return online;
}
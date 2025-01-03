import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionController extends GetxController{

  bool isConnected = false;
  late StreamSubscription<InternetConnectionStatus> _connectionListener;

  void listenToConnection() {
    _connectionListener =
        InternetConnectionChecker.instance.onStatusChange.listen((status) {
          if (status == InternetConnectionStatus.connected) {
            isConnected = true;
            update();
          } else {
            isConnected = false;
            update();
          }
        });
  }

  @override
  void onInit() {
    super.onInit();
    listenToConnection(); // Start listening to connection status
  }

  @override
  void onClose() {
    _connectionListener.cancel(); // Stop listening when the controller is disposed
    super.onClose();
  }
}
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectionStatus(result);
    });
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar('You\'re offline', 'Please check your internet connection',
          backgroundColor: Colors.red,
          isDismissible: false,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(days: 2));
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
        Get.snackbar('', 'Back Online!',
            backgroundColor: const Color(0xFF00FF00),
            isDismissible: true,
            duration: const Duration(seconds: 3));
      }
    }
  }
}

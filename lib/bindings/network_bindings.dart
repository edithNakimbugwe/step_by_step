import 'package:get/get.dart';

import '../controllers/network_controllers.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkController());
  }
}

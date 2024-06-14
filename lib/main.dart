import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/screens/landing_screen.dart';

import 'controllers/network_controllers.dart';

 void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final NetworkController networkController = NetworkController();
  Get.put(networkController);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

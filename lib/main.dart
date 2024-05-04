import 'package:flutter/material.dart';
import 'package:step_by_step/screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingScreen(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
    );
  }
}

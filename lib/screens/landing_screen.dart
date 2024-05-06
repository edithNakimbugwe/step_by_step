import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/controllers/landing_page_controllers.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LandingPageController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Landing Page"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Images',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman'),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter your name',
                hintText: 'Full Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Image.asset(
                controller.currentImageUrl,
                height: 200,
                width: 800,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Text(controller.identifyImage()))
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
              bottom: 60,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  controller.nextImage();
                },
                child: const Icon(Icons.skip_next),
              )),
          Positioned(
              bottom: 150,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  controller.previousImage();
                },
                child: const Icon(Icons.skip_previous),
              ))
        ],
      ),
    );
  }
}

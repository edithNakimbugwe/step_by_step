import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/screens/add_customer_form.dart';
import 'package:step_by_step/screens/add_supplier_form.dart';
import 'package:step_by_step/screens/preview_screen.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: MyTextWidget(
            text: 'Egg Management',
            colors: Colors.white,
            isHeading: true,
          ),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            MyTextWidget(
              text: 'Welcome!',
              colors: Colors.purple,
              isHeading: true,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextWidget(text: 'Please select section'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const AddSupplierForm());
              },
              style: const ButtonStyle(),
              child: MyTextWidget(text: 'Suppliers'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const AddCustomerForm());
                },
                child: MyTextWidget(
                  text: 'Customers',
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const PreviewScreen());
                },
                child: MyTextWidget(
                  text: 'PREVIEW',
                  colors: Colors.purple,
                ))
          ],
        )),
      ),
    );
  }
}

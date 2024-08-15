// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/controllers/add_customer_controller.dart';
import 'package:step_by_step/screens/manage_customers.dart';
import 'package:step_by_step/services/api_service.dart';
import 'package:step_by_step/widgets/general_form_field_widget.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class AddCustomerForm extends StatefulWidget {
  const AddCustomerForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddCustomerFormState createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final addCustomerController = Get.put(AddCustomerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: MyTextWidget(
            text: 'New Customer',
            isHeading: true,
            colors: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Form(
          key: addCustomerController.addCustomerFormKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GeneralTextFormFieldWidget(
                    validation: addCustomerController.validateCustomerName,
                    text: MyTextWidget(text: 'Customer Name:'),
                    controller: addCustomerController.customerNameControl,
                    hint: 'Enter customer name here',
                  ),
                  const SizedBox(height: 20),
                  GeneralTextFormFieldWidget(
                    validation: addCustomerController.validateContact,
                    text: MyTextWidget(text: 'Contact'),
                    controller: addCustomerController.contactControl,
                    hint: 'Enter contact',
                  ),
                  const SizedBox(height: 20),
                  GeneralTextFormFieldWidget(
                    validation: addCustomerController.validateLocation,
                    text: MyTextWidget(text: 'Location'),
                    controller: addCustomerController.locationControl,
                    hint: 'Enter location',
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (addCustomerController.addCustomerFormKey.currentState!
                          .validate()) {
                        ApiService.sendData('customer', {
                          'name':
                              addCustomerController.customerNameControl.text,
                          'contact': addCustomerController.contactControl.text,
                          'location':
                              addCustomerController.locationControl.text,
                        }).then((_) {
                          _showSuccessDialog(context);
                        }).catchError((error) {
                          _showErrorDialog(context, error.toString());
                        });
                      }
                    },
                    child: MyTextWidget(
                      text: 'Add Customer',
                      colors: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => const ManageCustomers());
                      },
                      child: MyTextWidget(text: 'Manage Customers'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: MyTextWidget(
            text: 'Saved',
            isHeading: true,
            colors: Colors.green,
          ),
          content: const Icon(
            Icons.done,
            color: Colors.purple,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: MyTextWidget(text: 'OK'),
            ),
          ],
          backgroundColor: Colors.amber[50],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: MyTextWidget(
            text: 'Error',
            isHeading: true,
            colors: Colors.red,
          ),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: MyTextWidget(text: 'OK'),
            ),
          ],
          backgroundColor: Colors.amber[50],
        );
      },
    );
  }
}

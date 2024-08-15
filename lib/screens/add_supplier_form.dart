// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/controllers/add_supplier_controller.dart';
import 'package:step_by_step/screens/manage_suppliers.dart';
import 'package:step_by_step/services/api_service.dart';
import 'package:step_by_step/widgets/general_form_field_widget.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class AddSupplierForm extends StatefulWidget {
  const AddSupplierForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddSupplierFormState createState() => _AddSupplierFormState();
}

class _AddSupplierFormState extends State<AddSupplierForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addSupplierController = Get.put(AddSupplierController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: MyTextWidget(
            text: 'New Supplier',
            isHeading: true,
            colors: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Form(
            key: addSupplierController.addSupplierFormKey,
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GeneralTextFormFieldWidget(
                            validation:
                                addSupplierController.validateSupplierName,
                            text: MyTextWidget(text: 'Supplier Name:'),
                            controller:
                                addSupplierController.supplierNameControl,
                            hint: 'Enter Supplier name here',
                          ),
                          const SizedBox(height: 20),
                          GeneralTextFormFieldWidget(
                            validation: addSupplierController.validateContact,
                            text: MyTextWidget(text: 'Contact'),
                            controller: addSupplierController.contactControl,
                            hint: 'Enter contact',
                          ),
                          const SizedBox(height: 20),
                          GeneralTextFormFieldWidget(
                            validation: addSupplierController.validateLocation,
                            text: MyTextWidget(text: 'Location'),
                            controller: addSupplierController.locationControl,
                            hint: 'Enter location',
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                              onPressed: () {
                                if (addSupplierController
                                    .addSupplierFormKey.currentState!
                                    .validate()) {
                                  ApiService.sendData('supplier', {
                                    'name': addSupplierController
                                        .supplierNameControl.text,
                                    'contact': addSupplierController
                                        .contactControl.text,
                                    'location': addSupplierController
                                        .locationControl.text,
                                  }).then((_) {
                                    _showSuccessDialog(context);
                                  }).catchError((error) {
                                    _showErrorDialog(context, error.toString());
                                  });
                                }
                              },
                              child: MyTextWidget(
                                text: 'Add Supplier',
                                colors: Colors.purple,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.to(() => const ManageSuppliers());
                              },
                              child: MyTextWidget(text: 'Manage Suppliers'))
                        ])))),
      ),
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: MyTextWidget(
          text: 'Saved',
          isHeading: true,
          colors: Colors.purple,
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

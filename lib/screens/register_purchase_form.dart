// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/controllers/date_field_controller.dart';
import 'package:step_by_step/controllers/dropdown_controller.dart';
import 'package:step_by_step/controllers/register_purchase_controller.dart';
import 'package:step_by_step/services/api_service.dart';
import 'package:step_by_step/widgets/general_form_field_widget.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';
import 'package:step_by_step/widgets/suppliers_dropdown.dart';

class RegisterPurchaseForm extends StatefulWidget {
  const RegisterPurchaseForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPurchaseFormState createState() => _RegisterPurchaseFormState();
}

class _RegisterPurchaseFormState extends State<RegisterPurchaseForm> {
  bool isIncomeSelected = true;

  @override
  void initState() {
    super.initState();
  }

  void _refreshData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final addPurchaseController = Get.put(AddPurchaseController());
    final dropdownController = Get.put(DropdownController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 80, 10, 8),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTextWidget(
                  text: 'New Stock Purchase',
                  isHeading: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: addPurchaseController.addPurchaseFormKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          CustomDateFormField(
                            validate: addPurchaseController.validateDate,
                            text: MyTextWidget(
                              text: 'Date',
                            ),
                            hintText: 'Enter date',
                            userFunction: () =>
                                addPurchaseController.selectDate(context),
                            dateIcon: const Icon(Icons.calendar_today),
                            dateController: addPurchaseController.dateControl,
                          ),
                          SupplierCustomDropdown(
                              hintText: 'Select',
                              text: MyTextWidget(text: 'Supplier'),
                              selectedItem: dropdownController.selectedItem,validate: dropdownController.validateItem,),
                          const SizedBox(height: 10),
                          GeneralTextFormFieldWidget(
                            validation:
                                addPurchaseController.validateNumberOfTrays,
                            text: MyTextWidget(text: 'Number Of Trays'),
                            controller:
                                addPurchaseController.numberOfTraysControl,
                            hint: 'required',
                          ),
                          GeneralTextFormFieldWidget(
                            validation:
                                addPurchaseController.validateCostPerTray,
                            text: MyTextWidget(text: 'Cost Per Tray'),
                            controller:
                                addPurchaseController.costPerTrayControl,
                            hint: 'Enter cost',
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 60,
                            width: 400,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            child: Obx(() {
                              return Center(
                                child: MyTextWidget(
                                  text:
                                      'Total Amount is ${addPurchaseController.getTotal()}',
                                  colors: Colors.purple,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 40),
                          InkWell(
                            onTap: () {
                              if (addPurchaseController
                                  .addPurchaseFormKey.currentState!
                                  .validate()) {
                                ApiService.sendData('purchase', {
                                  'supplier_name':
                                      dropdownController.selectedItem.value,
                                  'date':
                                      addPurchaseController.dateControl.text,
                                  'number_of_trays': addPurchaseController
                                      .numberOfTraysControl.text,
                                  'cost_per_tray': addPurchaseController
                                      .costPerTrayControl.text,
                                  'total': addPurchaseController.getTotal(),
                                }).then((_) {
                                  _refreshData();
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
                                          Icons.done_all_sharp,
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
                                }).catchError((error) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: MyTextWidget(
                                          text: 'Error',
                                          isHeading: true,
                                          colors: Colors.red,
                                        ),
                                        content: const Icon(
                                          Icons.done_all_sharp,
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
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: MyTextWidget(
                                  text: 'Save',
                                  colors: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/controllers/add_sale_controller.dart';
import 'package:step_by_step/controllers/date_field_controller.dart';
import 'package:step_by_step/controllers/dropdown_controller.dart';
import 'package:step_by_step/services/api_service.dart';
import 'package:step_by_step/widgets/customer_dropdown.dart';
import 'package:step_by_step/widgets/general_form_field_widget.dart';
import 'package:step_by_step/widgets/my_dropdown_widget.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class RegisterSaleForm extends StatefulWidget {
  const RegisterSaleForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterSaleFormState createState() => _RegisterSaleFormState();
}

class _RegisterSaleFormState extends State<RegisterSaleForm> {
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
    final addsaleController = Get.put(AddSaleController());
    final dropdownController = Get.put(DropdownController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 80, 10, 8),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTextWidget(
                  text: 'New Sales Record',
                  isHeading: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: addsaleController.addSaleFormKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          CustomDateFormField(
                            validate: addsaleController.validateDate,
                            text: MyTextWidget(
                              text: 'Date',
                            ),
                            hintText: 'Enter date',
                            userFunction: () =>
                                addsaleController.selectDate(context),
                            dateIcon: const Icon(Icons.calendar_today),
                            dateController: addsaleController.dateControl,
                          ),
                          CustomerCustomDropdown(
                              hintText: 'Select',
                              text: MyTextWidget(text: 'Customer'),
                              validate: dropdownController.validateItem,
                              selectedItem: dropdownController.selectedItem1),
                          const SizedBox(height: 10),
                          CustomDropdown(
                            hintText: 'Select',
                            text: MyTextWidget(text: 'Payment Method'),
                            validate: dropdownController.validateItem,
                            selectedItem: dropdownController.selectedItem2,
                            options: const [
                              'Cash',
                              'Mobile Money',
                              'Cheque',
                              'Online Banking'
                            ],
                          ),
                          const SizedBox(height: 10),
                          GeneralTextFormFieldWidget(
                            validation: addsaleController.validateNumberOfTrays,
                            text: MyTextWidget(text: 'Number Of Trays Sold'),
                            controller: addsaleController.numberOfTraysControl,
                            hint: 'required',
                          ),
                          GeneralTextFormFieldWidget(
                            validation: addsaleController.validateCostPerTray,
                            text: MyTextWidget(text: 'Selling Price Per Tray'),
                            controller: addsaleController.costPerTrayControl,
                            hint: 'Enter selling price',
                          ),
                          const SizedBox(height: 10),
                          GeneralTextFormFieldWidget(
                            validation: addsaleController.validateAmountPaid,
                            text: MyTextWidget(text: 'Amount Paid'),
                            controller: addsaleController.amountPaidControl,
                            hint: 'Enter amount paid by customer',
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
                                      'Total Amount is ${addsaleController.getTotal()}',
                                  colors: Colors.purple,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                                      'Amount Left is ${addsaleController.getBalace()}',
                                  colors: Colors.red,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 40),
                          InkWell(
                            onTap: () {
                              if (addsaleController.addSaleFormKey.currentState!
                                  .validate()) {
                                ApiService.sendData('sales', {
                                  'customer_name':
                                      dropdownController.selectedItem1.value,
                                  'date': addsaleController.dateControl.text,
                                  'payment_method':
                                      dropdownController.selectedItem2.value,
                                  'number_of_trays': addsaleController
                                      .numberOfTraysControl.text,
                                  'cost_per_tray':
                                      addsaleController.costPerTrayControl.text,
                                  'amount_paid':
                                      addsaleController.amountPaidControl.text,
                                  'total': addsaleController.getTotal(),
                                  'balance': addsaleController.getBalace(),
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

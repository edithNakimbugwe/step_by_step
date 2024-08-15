// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/controllers/add_sale_controller.dart';
import 'package:step_by_step/controllers/date_field_controller.dart';
import 'package:step_by_step/controllers/dropdown_controller.dart';
import 'package:step_by_step/screens/add_sale_record.dart';
import 'package:step_by_step/screens/register_purchase_form.dart';
import 'package:step_by_step/services/api_service.dart';
import 'package:step_by_step/widgets/customer_dropdown.dart';
import 'package:step_by_step/widgets/general_form_field_widget.dart';
import 'package:step_by_step/widgets/my_dropdown_widget.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool isSalesSelected = true;
  late Future<List<dynamic>> _data;
  final addsaleController = Get.put(AddSaleController());
  final dropdownController = Get.put(DropdownController());

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  Future<List<dynamic>> _getData() {
    return isSalesSelected
        ? ApiService.getData('sales')
        : ApiService.getData('purchase');
  }

  void toggleSelection(bool isSales) {
    setState(() {
      isSalesSelected = isSales;
      _data = _getData();
    });
  }

  void _refreshData() {
    setState(() {
      _data = _getData();
    });
  }

  void _editSales(dynamic id) async {
    print('Inside _editSales with id: $id');
    try {
      // Convert id to an integer if it's a string
      int saleId = int.tryParse(id.toString()) ?? id;

      // Await the Future to get the actual data list
      List<dynamic> data = await _data;

      // Find the sale with the specified id
      var sale = data.firstWhere(
        (element) => element['id'] == saleId,
        orElse: () => null, // Provide a fallback if no match is found
      );

      // If sale is null, show an error message or handle accordingly
      if (sale == null) {
        print('Sale record with id $saleId not found.');
        return;
      }

      // Populate controllers with existing data
      addsaleController.dateControl.text = sale['date'] ?? '';
      addsaleController.numberOfTraysControl.text =
          sale['number_of_trays'].toString();
      addsaleController.costPerTrayControl.text =
          sale['cost_per_tray'].toString();
      addsaleController.amountPaidControl.text = sale['amount_paid'].toString();
      dropdownController.selectedItem1.value = sale['customer_name'] ?? '';
      dropdownController.selectedItem2.value = sale['payment_method'] ?? '';

      showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text('Edit Sales'),
              content: Form(
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
                          text: MyTextWidget(text: 'Date'),
                          hintText: 'Enter date',
                          userFunction: () =>
                              addsaleController.selectDate(context),
                          dateIcon: const Icon(Icons.calendar_today),
                          dateController: addsaleController.dateControl,
                        ),
                        CustomerCustomDropdown(
                          hintText: 'Select',
                          text: MyTextWidget(text: 'Customer'),
                          selectedItem: dropdownController.selectedItem1,
                        ),
                        const SizedBox(height: 10),
                        CustomDropdown(
                          hintText: 'Select',
                          text: MyTextWidget(text: 'Payment Method'),
                          selectedItem: dropdownController.selectedItem2,
                          options: [
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
                            border: Border.all(color: Colors.purple),
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                        const SizedBox(height: 20),
                        Container(
                          height: 60,
                          width: 400,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple),
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (addsaleController.addSaleFormKey.currentState!
                        .validate()) {
                      ApiService.updateData('sales', saleId, {
                        'customer_name': dropdownController.selectedItem1.value,
                        'date': addsaleController.dateControl.text,
                        'payment_method':
                            dropdownController.selectedItem2.value,
                        'number_of_trays': double.tryParse(
                                addsaleController.numberOfTraysControl.text) ??
                            0.0,
                        'cost_per_tray': double.tryParse(
                                addsaleController.costPerTrayControl.text) ??
                            0.0,
                        'amount_paid': double.tryParse(
                                addsaleController.amountPaidControl.text) ??
                            0.0,
                        'total': addsaleController.getTotal(),
                        'balance': addsaleController.getBalace(),
                      }).then((_) {
                        _refreshData();
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: const Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Error in _editSales: $e');
    }
  }

  void _deleteRecord(dynamic id) {
    try {
      // Convert id to an integer if it's a string
      int recordId = int.tryParse(id.toString()) ?? id;

      ApiService.deleteData(isSalesSelected ? 'sales' : 'purchase', recordId)
          .then((_) {
        _refreshData();
      });
    } catch (e) {
      print('Error in _deleteRecord: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyTextWidget(
          text: 'PREVIEW',
          isHeading: true,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: Colors.purple,
            height: 3.0,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSalesSelected ? Colors.purple : Colors.white,
                  ),
                  width: 202,
                  height: 60,
                  child: Center(
                      child: MyTextWidget(
                    text: 'Sales',
                    colors: isSalesSelected ? Colors.white : Colors.black,
                  )),
                ),
                onTap: () => toggleSelection(true),
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSalesSelected ? Colors.white : Colors.purple,
                  ),
                  width: 202,
                  height: 60,
                  child: Center(
                      child: MyTextWidget(
                    text: 'Purchases',
                    colors: isSalesSelected ? Colors.black : Colors.white,
                  )),
                ),
                onTap: () => toggleSelection(false),
              )
            ],
          ),
          isSalesSelected
              ? Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: _data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return SingleChildScrollView(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Customer Name')),
                                DataColumn(label: Text('Payment Method')),
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('No_ Of Trays Sold')),
                                DataColumn(
                                    label: Text('Selling Price Per Tray')),
                                DataColumn(label: Text('Total Amount')),
                                DataColumn(label: Text('Balance')),
                                DataColumn(label: Text('Amount Paid')),
                                DataColumn(label: Text('Edit')),
                                DataColumn(label: Text('Delete')),
                              ],
                              rows: snapshot.data!.map<DataRow>((sale) {
                                final id = sale['id'];
                                final customerName =
                                    sale['customer_name'] ?? 'Not provided';
                                final paymentMethod =
                                    sale['payment_method'] ?? 'Not provided';
                                final date = sale['date'] ?? 'Not provided';
                                final quantity = sale['number_of_trays'] is int
                                    ? (sale['number_of_trays'] as int)
                                        .toDouble()
                                    : sale['number_of_trays'];
                                final cost = sale['cost_per_tray'] is int
                                    ? (sale['cost_per_tray'] as int).toDouble()
                                    : sale['cost_per_tray'];
                                final total = sale['total'] is int
                                    ? (sale['total'] as int).toDouble()
                                    : sale['total'];
                                final balance = sale['balance'] is int
                                    ? (sale['balance'] as int).toDouble()
                                    : sale['balance'];
                                final amountPaid = sale['amount_paid'] is int
                                    ? (sale['amount_paid'] as int).toDouble()
                                    : sale['amount_paid'];

                                return DataRow(
                                  cells: [
                                    DataCell(Text(customerName)),
                                    DataCell(Text(paymentMethod)),
                                    DataCell(Text(date)),
                                    DataCell(Text(quantity.toString())),
                                    DataCell(Text(cost.toString())),
                                    DataCell(Text(total.toString())),
                                    DataCell(Text(
                                      balance.toString(),
                                      style: const TextStyle(color: Colors.red),
                                    )),
                                    DataCell(Text(amountPaid.toString())),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          print('Edit button tapped');
                                          _editSales(id);
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _deleteRecord(id);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
              : Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: _data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return SingleChildScrollView(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Suplier Name')),
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('Trays Purchased')),
                                DataColumn(label: Text('Cost Per Tray')),
                                DataColumn(label: Text('Total Amount')),
                                DataColumn(label: Text('Edit')),
                                DataColumn(label: Text('Delete')),
                              ],
                              rows: snapshot.data!.map<DataRow>((purchase) {
                                final id = purchase['id'];
                                final supplierName =
                                    purchase['supplier_name'] ?? 'Not provided';
                                final date = purchase['date'] ?? 'Not provided';
                                final quantity =
                                    purchase['number_of_trays'] is int
                                        ? (purchase['number_of_trays'] as int)
                                            .toDouble()
                                        : purchase['number_of_trays'];
                                final cost = purchase['cost_per_tray'] is int
                                    ? (purchase['cost_per_tray'] as int)
                                        .toDouble()
                                    : purchase['cost_per_tray'];
                                final total = purchase['total'] is int
                                    ? (purchase['total'] as int).toDouble()
                                    : purchase['total'];

                                return DataRow(
                                  cells: [
                                    DataCell(Text(supplierName)),
                                    DataCell(Text(date)),
                                    DataCell(Text(quantity.toString())),
                                    DataCell(Text(cost.toString())),
                                    DataCell(Text(total.toString())),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          print('Edit button tapped');
                                          _editSales(id);
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _deleteRecord(id);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
        ],
      ),
      floatingActionButton: InkWell(
          onTap: () => isSalesSelected
              ? Get.to(() => const RegisterSaleForm())
              : Get.to(() => const RegisterPurchaseForm()),
          child: Container(
            height: 45,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.purple,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                MyTextWidget(
                  text: isSalesSelected ? 'Sales' : 'Purchases',
                  colors: Colors.white,
                )
              ],
            ),
          )),
    );
  }
}

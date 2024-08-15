import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPurchaseController extends GetxController {
  final dateControl = TextEditingController();
  final supplierNameControl = TextEditingController();
  final numberOfTraysControl = TextEditingController();
  final costPerTrayControl = TextEditingController();
final totalControl = TextEditingController();  

  final GlobalKey<FormState> addPurchaseFormKey = GlobalKey<FormState>();

  var cost = 0.obs;
  var quantity = 0.obs;

  int getTotal() {
    return cost.value * quantity.value;
  }

  String? validateDate(String? date) {
    if (date == '' || date == null) {
      return 'Enter date';
    }
    return null;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dateControl.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  String? validateSupplierName(String? cName) {
    if (cName == '' || cName == null) {
      return 'Required';
    }
    return null;
  }

  String? validateCostPerTray(String? cost) {
    if (cost == '' || cost == null) {
      return 'Enter cost';
    }
    final parsedValue = int.tryParse(cost);
    if (parsedValue == null) {
      return 'Enter a valid number';
    }
    this.cost.value = parsedValue;
    return null;
  }

 

  String? validateNumberOfTrays(String? quantity) {
    if (quantity == '' || quantity == null) {
      return 'Enter quantity';
    }
    final parsedValue = int.tryParse(quantity);
    if (parsedValue == null) {
      return 'Enter a valid number';
    }
    this.quantity.value = parsedValue;
    return null;
  }
}
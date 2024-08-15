import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSupplierController extends GetxController {
  final supplierNameControl = TextEditingController();
  final contactControl = TextEditingController();
  final companyControl = TextEditingController();
  final locationControl = TextEditingController();

  final GlobalKey<FormState> addSupplierFormKey = GlobalKey<FormState>();

  String? validateSupplierName(String? cName) {
    if (cName == '' || cName == null) {
      return 'Required';
    }
    return null;
  }

  String? validateContact(String? contact) {
    if (contact == '' || contact == null) {
      return 'Required';
    }
    return null;
  }
  String? validateCompany(String? company) {
    if (company == '' || company == null) {
      return 'Required';
    }
    return null;
  }

  String? validateLocation(String? location) {
    if (location == '' || location == null) {
      return 'Required';
    }
    return null;
  }
}

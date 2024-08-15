import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController {
  final customerNameControl = TextEditingController();
  final contactControl = TextEditingController();
  final locationControl = TextEditingController();

  final GlobalKey<FormState> addCustomerFormKey = GlobalKey<FormState>();

  String? validateCustomerName(String? cName) {
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

  String? validateLocation(String? location) {
    if (location == '' || location == null) {
      return 'Enter method';
    }
    return null;
  }
}

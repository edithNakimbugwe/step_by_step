import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedItem = ''.obs;
  var selectedItem1 = ''.obs; 
  var selectedItem2 = ''.obs;
  var selectedItem3 = ''.obs;
  var selectedItem4 = ''.obs;
  var selectedItem5 = ''.obs;
  var selectedItem6 = ''.obs;
  var selectedItem7 = ''.obs;
  var selectedItem8 = ''.obs;
  var selectedItem9 = ''.obs;
  var selectedItem10 = ''.obs;

  // void updateSelectedItem(String newValue) {
  //   selectedItem.value = newValue;
  // }

  String? validateItem(String? item) {
    if (item == '' || item == null) {
      return 'Required';
    }
    return null;
  }
}

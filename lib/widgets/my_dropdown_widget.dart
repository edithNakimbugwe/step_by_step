import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final MyTextWidget text;
  final List<String> options;
  final RxString selectedItem;
  final String? Function(String?)? validate;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.text,
    required this.options,
    required this.selectedItem,
    this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentItem =
          options.contains(selectedItem.value) ? selectedItem.value : null;

      return DropdownButtonFormField<String>(
        value: currentItem,
        validator: validate,
        decoration: InputDecoration(
          label: text,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 15),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.purple),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            selectedItem.value = value;
          }
        },
      );
    });
  }
}

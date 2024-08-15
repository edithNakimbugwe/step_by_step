import 'package:flutter/material.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class CustomDateFormField extends StatelessWidget {
  final TextEditingController dateController;
  final Icon dateIcon;
  final VoidCallback userFunction;
  final String hintText;
  final MyTextWidget text;
  // ignore: prefer_typing_uninitialized_variables
  final validate;
  const CustomDateFormField(
      {super.key,
      required this.userFunction,
      required this.dateController,
      required this.hintText,
      required this.text,
      required this.dateIcon,
      required this.validate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: dateController,
      validator: validate,
      decoration: InputDecoration(
        label: text,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 15),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        suffixIcon: IconButton(
          onPressed: userFunction,
          icon: dateIcon,
          color: Colors.purple,
        ),
      ),
    );
  }
}

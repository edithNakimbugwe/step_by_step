import 'package:flutter/material.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

// ignore: must_be_immutable
class GeneralTextFormFieldWidget extends StatelessWidget {
  GeneralTextFormFieldWidget(
      {super.key,
      required this.validation,
      required this.text,
      this.colors = Colors.black,
      required this.controller,
      required this.hint});

  final MyTextWidget text;

  Color colors;
  final Function validation;
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validation(value),
      controller: controller,
      decoration: InputDecoration(
        label: text,
        hintText: hint,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
      ),
    );
  }
}

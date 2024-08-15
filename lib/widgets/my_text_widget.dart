import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyTextWidget extends StatelessWidget {
  MyTextWidget(
      {super.key,
      required this.text,
      this.colors = Colors.black,
      this.isHeading = false});

  final String text;
  Color colors;
  bool isHeading;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: isHeading
          ? GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: colors, fontSize: 24, fontWeight: FontWeight.bold),
            )
          : GoogleFonts.lora(
              textStyle: TextStyle(
                color: colors,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
    );
  }
}

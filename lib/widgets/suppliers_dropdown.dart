import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SupplierCustomDropdown extends StatefulWidget {
  final String hintText;
  final MyTextWidget text;
  final RxString selectedItem;
  final String? Function(String?)? validate;

  const SupplierCustomDropdown({
    super.key,
    required this.hintText,
    required this.text,
    required this.selectedItem,
    this.validate,
  });

  @override
  _SupplierCustomDropdownState createState() => _SupplierCustomDropdownState();
}

class _SupplierCustomDropdownState extends State<SupplierCustomDropdown> {
  late Future<List<String>> dropdownOptions;

  Future<List<String>> fetchDropdownOptions() async {
    final response = await http.get(Uri.parse(
        'http://uetcl.dev/balance_inq_api/api.php?table=supplier&column=name'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Extract the specific column values from each map
      List<String> options =
          data.map((item) => item['name'].toString()).toList();

      return options;
    } else {
      throw Exception('Failed to load dropdown options');
    }
  }

  @override
  void initState() {
    super.initState();
    dropdownOptions = fetchDropdownOptions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: dropdownOptions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final options = snapshot.data!;
          final currentItem = options.contains(widget.selectedItem.value)
              ? widget.selectedItem.value
              : null;

          return DropdownButtonFormField<String>(
            value: currentItem,
            validator: widget.validate,
            decoration: InputDecoration(
              label: widget.text,
              hintText: widget.hintText,
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
                widget.selectedItem.value = value;
              }
            },
          );
        } else {
          return Text('No options available');
        }
      },
    );
  }
}
